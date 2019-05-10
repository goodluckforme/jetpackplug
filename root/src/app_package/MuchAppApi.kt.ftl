package ${apipackageName}

import android.util.Log
import ${apipackageName}.AppService
import ${baseContractPackageName}.IP
import ${baseContractPackageName}.PORT
import ${entityPackageName}.HttpResult
import ${packageName}.utils.SharedPreferencesUtil
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.observers.DisposableObserver
import io.reactivex.schedulers.Schedulers
import okhttp3.*
import okhttp3.logging.HttpLoggingInterceptor
import okio.*
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.io.File
import java.io.IOException
import java.util.concurrent.TimeUnit


/**
 * Created by MaQi on 2017/12/21.
 */
class AppApi() {

    /**
     * Description: 带进度 下载请求体
     * Created by jia on 2017/11/30.
     * 人之所以能，是相信能
     */
    inner class JsResponseBody(
        private val responseBody: ResponseBody,
        private val downloadListener: JsDownloadListener?
    ) : ResponseBody() {

        // BufferedSource 是okio库中的输入流，这里就当作inputStream来使用。
        private var bufferedSource: BufferedSource? = null

        override fun contentType(): MediaType? {
            return responseBody.contentType()
        }

        override fun contentLength(): Long {
            return responseBody.contentLength()
        }

        override fun source(): BufferedSource {
            if (bufferedSource == null) {
                bufferedSource = Okio.buffer(source(responseBody.source()))
            }
            return bufferedSource!!
        }

        private fun source(source: Source): Source {
            return object : ForwardingSource(source) {
                internal var totalBytesRead = 0L

                @Throws(IOException::class)
                override fun read(sink: Buffer, byteCount: Long): Long {
                    val bytesRead = super.read(sink, byteCount)
                    // read() returns the number of bytes read, or -1 if this source is exhausted.
                    totalBytesRead += if (bytesRead != -1L) bytesRead else 0
                    Log.e("download", "read: " + (totalBytesRead * 100 / responseBody.contentLength()).toInt())
                    if (null != downloadListener) {
                        if (bytesRead != -1L) {
                            downloadListener.onProgress((totalBytesRead * 100 / responseBody.contentLength()).toInt())
                        }

                    }
                    return bytesRead
                }
            }

        }
    }

    /**
     * Description: 下载进度回调
     * Created by jia on 2017/11/30.
     * 人之所以能，是相信能
     */
    interface JsDownloadListener {

        fun onStartDownload()

        fun onProgress(progress: Int)

        fun onFinishDownload(path: String)

        fun onFail(errorInfo: String)

    }

    private object Holder {
        val INSTANCE = AppApi()
    }

    companion object {
        val instance: AppApi by lazy {
            Holder.INSTANCE
        }
    }

    private var appService: AppService

    init {
        appService = getRetrofit().build().create(AppService::class.java)
    }

    fun resetRetrofit(ip: String, port: String) {
        appService = getRetrofit(ip, port).build().create(AppService::class.java)
    }

    /**
     * Description: 带进度 下载  拦截器
     * Created by jia on 2017/11/30.
     * 人之所以能，是相信能
     */
    inner class JsDownloadInterceptor(private val downloadListener: JsDownloadListener) : Interceptor {

        @Throws(IOException::class)
        override fun intercept(chain: Interceptor.Chain): Response {
            val response = chain.proceed(chain.request())
            return response.newBuilder().body(
                JsResponseBody(response.body()!!, downloadListener)
            ).build()
        }
    }

    private fun getRetrofit(
        ip: String = SharedPreferencesUtil.instance.getString("IP", IP).toString(),
        port: String = SharedPreferencesUtil.instance.getString("PORT", PORT).toString()
    ): Retrofit.Builder {
        return Retrofit.Builder()
            .baseUrl("http://$ip:$port/")
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create()) // 添加Rx适配器
            //.addCallAdapterFactory(LiveDataCallAdapterFactory())//LiveData 适配器
            //.addConverterFactory(MoshiConverterFactory.create(Moshi.Builder().add(KotlinJsonAdapterFactory()).build())) Moshi 适配器
            .addConverterFactory(GsonConverterFactory.create()) // 添加Gson转换器
            .client(getOKClient().build())
    }

    private fun getOKClient(): OkHttpClient.Builder {
        //初始化拦截器
        val mTokenInterceptor = object : Interceptor {
            @Throws(IOException::class)
            override fun intercept(chain: Interceptor.Chain): Response {

                val token = SharedPreferencesUtil.instance.getString("Token", "")
                val originalRequest = chain.request()
                if (token.isNullOrEmpty())
                    return chain.proceed(originalRequest)
                val authorised = originalRequest.newBuilder()
                    .header("Authorization", token)
                    .build()
                return chain.proceed(authorised)
            }
        }

        val mLogInterceptor = HttpLoggingInterceptor(HttpLoggingInterceptor.Logger { message ->
            Log.i("AppApi", "AppApi -> $message")
        }).apply { level = HttpLoggingInterceptor.Level.BODY }
        return OkHttpClient.Builder()
            .connectTimeout((5 * 1000).toLong(), TimeUnit.MILLISECONDS)
            .readTimeout((5 * 1000).toLong(), TimeUnit.MILLISECONDS)
            .addInterceptor(mLogInterceptor) // 这个会全部打印出来
            .addInterceptor(mTokenInterceptor)
            .retryOnConnectionFailure(true) // 失败重发
    }


    private fun <T> observer(consumer: DisposableObserver<T>, observable: Observable<T>): Disposable? {
        return observable.subscribeOn(Schedulers.io())
            .unsubscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribeWith(consumer)
    }

    fun upload(key: String, file: File, observer: DisposableObserver<HttpResult<Any>>): Disposable? {
        val requestFile = RequestBody.create(MediaType.parse("multipart/form-data"), file)
        val data = MultipartBody.Part.createFormData("avatar", file.name, requestFile)
        val key = RequestBody.create(MediaType.parse("multipart/form-data"), key)
        val client = RequestBody.create(MediaType.parse("multipart/form-data"), "android")
        return observer(
            observer, appService.upload(
                key,
                data,
                client
            )
        )
    }

}