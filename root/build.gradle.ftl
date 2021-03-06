apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'kotlin-android-extensions'
apply plugin: 'kotlin-kapt'
//apply plugin: 'kotlin-allopen'

def keystorePropertiesFile = rootProject.file("keystore.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

def releaseTime() {
    return new Date().format("yyyyMMdd", TimeZone.getTimeZone("UTC"))
}

android {
    compileSdkVersion 28
    defaultConfig {
        applicationId "${packageName}"
        minSdkVersion 19
        targetSdkVersion 28
        versionCode 101
        versionName "1.0.1"
        multiDexEnabled true

        testInstrumentationRunner 'androidx.test.runner.AndroidJUnitRunner'
        //导出数据库
        javaCompileOptions {
            annotationProcessorOptions {
                arguments = ["room.schemaLocation":
                                     "$projectDir/schemas".toString()]
            }
        }
        vectorDrawables.useSupportLibrary = true

        ndk {
            abiFilters "armeabi-v7a", "x86", "arm64-v8a"
        }

       
       //<#noparse> buildConfigField 'String', 'API_KEY', "\"${propOrEmpty('API_KEY')}\""</#noparse>
    }
    signingConfigs {
        debug {
            keyAlias keystoreProperties['debugKeyAlias']
            keyPassword keystoreProperties['debugKeyPassword']
            storeFile file(rootDir.getCanonicalPath() + '/' + keystoreProperties['debugKeyStore'])
            storePassword keystoreProperties['debugStorePassword']
        }

        release {
            keyAlias keystoreProperties['releaseKeyAlias']
            keyPassword keystoreProperties['releaseKeyPassword']
            storeFile file(rootDir.getCanonicalPath() + '/' + keystoreProperties['releaseKeyStore'])
            storePassword keystoreProperties['releaseStorePassword']
        }
    }


    buildTypes {
        release {
            buildConfigField "boolean", "LOG_DEBUG", "false"
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            //签名
            signingConfig signingConfigs.release
            //apk命名
            android.applicationVariants.all { variant ->
                variant.outputs.all { output ->
                   outputFileName = "${packageName}-<#noparse>${variant.name}-${variant.versionName}-${releaseTime()</#noparse>}.apk"
                }
            }
        }
        debug {
            buildConfigField "boolean", "LOG_DEBUG", "true"
            signingConfig signingConfigs.debug
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    lintOptions {
        checkReleaseBuilds false
        abortOnError false
    }
    sourceSets {
        main {
            jni.srcDirs = []
            jniLibs.srcDirs = ['libs']
        }
    }
    repositories {
        flatDir {
            dirs 'libs'
        }
    }

    dataBinding {
        enabled true
    }

    packagingOptions {
        exclude ".readme"
        exclude "META-INF/LICENSE.txt"
        exclude "META-INF/NOTICE.txt"
        exclude 'META-INF/proguard/androidx-annotations.pro'
        exclude 'META-INF/library_release.kotlin_module'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
        test.java.srcDirs += 'src/test/kotlin'
    }
}
kapt {
    generateStubs = true
}

dependencies {
    implementation fileTree(include: ['*.jar'], dir: 'libs')

    // Testing frameworks
    testImplementation 'org.koin:koin-test:1.0.2'
    androidTestImplementation 'org.koin:koin-test:1.0.2'
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'androidx.test:core:1.1.0'
    androidTestImplementation "androidx.test.ext:junit:1.1.0"
    androidTestImplementation 'androidx.test:rules:1.1.1'
    implementation 'androidx.test.espresso:espresso-idling-resource:3.1.1'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'
    androidTestImplementation 'androidx.test.espresso:espresso-contrib:3.1.1'
    implementation 'com.google.code.findbugs:jsr305:3.0.2'
    testImplementation 'androidx.arch.core:core-testing:2.0.1'
    androidTestImplementation 'androidx.arch.core:core-testing:2.0.1'
    testImplementation 'com.jraska.livedata:testing-ktx:1.0.0'
    androidTestImplementation 'com.jraska.livedata:testing-ktx:1.0.0'

    // Android Support Libraries
    implementation 'androidx.multidex:multidex:2.0.1'
    implementation 'androidx.annotation:annotation:1.0.2'
    implementation 'androidx.appcompat:appcompat:1.0.2'
    implementation 'com.google.android.material:material:1.0.0'
    implementation 'androidx.cardview:cardview:1.0.0'
    implementation 'androidx.constraintlayout:constraintlayout:1.1.3'

    // Android Lifecycle
    implementation 'androidx.lifecycle:lifecycle-common-java8:2.0.0'
    // For Kotlin use kapt instead of annotationProcessor
    kapt "androidx.lifecycle:lifecycle-compiler:2.0.0"
    implementation 'androidx.lifecycle:lifecycle-extensions:2.0.0'
    implementation 'androidx.room:room-runtime:2.1.0-alpha06'
    kapt "androidx.room:room-compiler:2.1.0-alpha06"
    implementation 'androidx.paging:paging-runtime:2.1.0'

    // KOTLIN
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"

    def  anko_version='0.10.4'
    implementation "org.jetbrains.anko:anko:$anko_version"

    // KOTLIN DEPENDENCY INJECTION
    implementation 'org.koin:koin-android:1.0.2'
    implementation 'org.koin:koin-android-viewmodel:1.0.2'

    // KOTLIN COROUTINES
    implementation "org.jetbrains.kotlinx:kotlinx-coroutines-core:1.1.1"
    implementation "org.jetbrains.kotlinx:kotlinx-coroutines-android:1.1.1"

    //gson
    implementation 'com.google.code.gson:gson:2.8.1'

    def  okhttp_version = '3.8.1'
    def  retrofit_version = '2.2.0'
    // Networking
    implementation "com.squareup.retrofit2:retrofit:$retrofit_version"
    implementation "com.squareup.retrofit2:converter-gson:$retrofit_version"
    implementation "com.squareup.retrofit2:adapter-rxjava2:$retrofit_version"
    implementation "com.squareup.okhttp3:okhttp:$okhttp_version"
    implementation "com.squareup.okhttp3:logging-interceptor:$okhttp_version"

    // Rx
    implementation "io.reactivex.rxjava2:rxjava:2.1.7"
    implementation 'io.reactivex.rxjava2:rxandroid:2.0.1'

    // Time Libraries
    implementation 'com.jakewharton.threetenabp:threetenabp:1.2.0'

//==================================以下部分非必须======================================
//    EventBus
//    implementation 'org.greenrobot:eventbus:3.1.1'
//    //蒲公英
//    implementation 'com.pgyersdk:sdk:2.8.1'
//    //RxView
//    //implementation 'com.jakewharton.rxbinding2:rxbinding:2.0.0'
//    //UI库
//    implementation 'com.qmuiteam:qmui:1.0.6'
//    //materialedittext
//    implementation 'com.rengwuxian.materialedittext:library:2.1.4'
//    //轮播图
//    implementation 'cn.bingoogolapple:bga-banner:2.1.8@aar'
//    implementation 'me.relex:circleindicator:1.2.2@aar'
//    // Glide
//    implementation 'com.github.bumptech.glide:glide:4.8.0'
//    kapt 'com.github.bumptech.glide:compiler:4.8.0'
//    //    implementation 'cn.bingoogolapple:bga-adapter:1.1.8@aar'
//    //    implementation 'cn.bingoogolapple:bga-photopicker:1.2.3@aar'
//    //高德定位
//    implementation 'com.amap.api:location:latest.integration'
//    //高德搜索
//    //    implementation 'com.amap.api:search:latest.integration'
//    //扫描二维码
//    implementation 'com.google.zxing:core:3.3.0'
//    implementation 'cn.bingoogolapple:bga-qrcodecore:1.1.9@aar'
//    implementation 'cn.bingoogolapple:bga-zxing:1.1.9@aar'
}