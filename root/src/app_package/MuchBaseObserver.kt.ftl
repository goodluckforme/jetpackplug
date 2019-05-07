package ${apipackageName}

import android.content.Context
import ${entityPackageName}.HttpResult
import ${utilsPackageName}.SharedPreferencesUtil
import io.reactivex.observers.DisposableObserver

/**
 * Created by MaQi on 2018/1/2.
 */
abstract class BaseObserver<T>() : DisposableObserver<HttpResult<T>>() {

    companion object {
        val SUCCESS = 0
        val FAILLOGIN = 210
        val USERINFO = ""
    }

    override fun onNext(result: HttpResult<T>) {
        when {
            result.result == SUCCESS -> onNetSuccess(result.datas)
            result.result == FAILLOGIN -> {
                onRequestFail(Throwable("$FAILLOGIN"))
            }
            else -> onRequestFail(Throwable(result.msg))
        }
    }

    override fun onError(e: Throwable) = onRequestFail()

    override fun onComplete() = onNetCompleted()

    protected fun onNetCompleted() {}

    abstract fun onRequestFail(e: Throwable = Throwable("服务器异常,请稍后重试"))
    abstract fun onNetSuccess(datas: T)
}