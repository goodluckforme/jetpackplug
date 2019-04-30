package com.xiaomakj.jetpackplug

import androidx.multidex.MultiDexApplication
import android.content.Context
import android.os.Handler
import android.os.Looper
import com.xiaomakj.jetpackplug.utils.SharedPreferencesUtil

/**
 * Created by MaQi
 */

class App : MultiDexApplication() {

    override fun onCreate() {
        super.onCreate()
        startKoin(this, listOf(appModule))
        instance = this
        SharedPreferencesUtil.init(this, packageName + "_preference", Context.MODE_PRIVATE)
    }

    companion object {
        lateinit var instance: App
    }


    val mainHandler: Handler by lazy {
        Handler(Looper.getMainLooper())
    }
}
