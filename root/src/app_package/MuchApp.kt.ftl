package ${packageName}

import androidx.multidex.MultiDexApplication
import ${utilsPackageName}.SharedPreferencesUtil
import android.content.Context
import android.os.Handler
import android.os.Looper
import com.jakewharton.threetenabp.AndroidThreeTen
import org.koin.android.ext.android.startKoin
/**
 * Created by MaQi
 */

class App: MultiDexApplication() {

    override fun onCreate() {
        super.onCreate()
        startKoin(this, listOf(appModule)+neededModule)
        AndroidThreeTen.init(this)
        SharedPreferencesUtil.init(this, packageName + "_preference", Context.MODE_PRIVATE)
        instance = this
    }

    companion object {
        lateinit var instance: App
    }

  
    val mainHandler: Handler by lazy {
        Handler(Looper.getMainLooper())
    }
}
