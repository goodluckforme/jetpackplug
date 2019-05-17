# Project-wide Gradle settings.
# IDE (e.g. Android Studio) users:
# Gradle settings configured through the IDE *will override*
# any settings specified in this file.
# For more details on how to configure your build environment visit
# http:#www.gradle.org/docs/current/userguide/build_environment.html
# Specifies the JVM arguments used for the daemon process.
# The setting is particularly useful for tweaking memory settings.
# org.gradle.jvmargs=-Xmx1536m
# When configured, Gradle will run in incubating parallel mode.
# This option should only be used with decoupled projects. More details, visit
# http:#www.gradle.org/docs/current/userguide/multi_project_builds.html#sec:decoupled_projects
# org.gradle.parallel=true
# AndroidX package structure to make it clearer which packages are bundled with the
# Android operating system, and which are packaged with your app's APK
# https:#developer.android.com/topic/libraries/support-library/androidx-rn
android.useAndroidX=true
# Automatically convert third-party libraries to use AndroidX
android.enableJetifier=true
# Kotlin code style for this project: "official" or "obsolete":
kotlin.code.style=official
#优化
#开启gradle并行编译，开启daemon，调整jvm内存大小
org.gradle.daemon=true
org.gradle.configureondemand=true
org.gradle.parallel=true
org.gradle.jvmargs=-Xmx4096m -XX:MaxPermSize=1024m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
#开启gradle缓存
org.gradle.caching=true
android.enableBuildCache=true
#开启kotlin的增量和并行编译
kotlin.incremental=true
kotlin.incremental.java=true
kotlin.incremental.js=true
kotlin.caching.enabled=true
kotlin.parallel.tasks.in.project=true #开启kotlin并行编译
#优化kapt
kapt.use.worker.api=true #并行运行kapt1.2.60版本以上支持
kapt.incremental.apt=true #增量编译 kapt1.3.30版本以上支持
#kapt avoiding 如果用kapt依赖的内容没有变化，会完全重用编译内容，省掉最上图中的:app:kaptGenerateStubsDebugKotlin的时间
kapt.include.compile.classpath=false
