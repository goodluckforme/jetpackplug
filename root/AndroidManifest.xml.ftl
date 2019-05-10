<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="${packageName}">
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    <uses-permission android:name="android.permission.CALL_PHONE"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/> <!-- 获取网络状态 -->
    <uses-permission android:name="android.permission.INTERNET"/> <!-- 网络通信 -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/> <!-- 获取设备信息 -->
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/> <!-- 获取MAC地址 -->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/> <!-- 读写sdcard，storage等等 -->
    <uses-permission android:name="android.permission.RECORD_AUDIO"/> <!-- 允许程序录制音频 -->
    <uses-permission android:name="android.permission.GET_TASKS"/>
    <application
            android:allowBackup="true"
            android:icon="@mipmap/logo"
            android:networkSecurityConfig="@xml/network_security_config"
            android:label="@string/app_name"
            android:roundIcon="@mipmap/logo"
			android:name=".App"
            android:supportsRtl="true"
            android:theme="@style/AppTheme">
        <provider
            android:name="androidx.core.content.FileProvider"
           android:authorities="<#noparse>$</#noparse>{applicationId}.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths" />
        </provider>
         <activity android:name="${ativityPackageName}.${activityClass}" android:screenOrientation="portrait">
            <#if needInintBase>
                <intent-filter>
                    <action android:name="android.intent.action.MAIN"/>
                    <action android:name="android.intent.action.VIEW"/>
                    <category android:name="android.intent.category.LAUNCHER"/>
                </intent-filter>
            </#if>
        </activity>
    </application>
</manifest>
