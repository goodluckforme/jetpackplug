### 前言：
> 就在上个月创建JetPack专栏以来，我发现我的博文被阅读的次数只有可怜十位数，甚至个位数那么少，于是乎自行翻看原来的文章，发现确实很容易出现断片的感觉，因为大多数是基于Github某些知名项目做得源码分析，以及相应的举一反三，需要依靠读者亲身阅读源码并动手尝试才能有所体会，为了不让读者看不懂，也不让自己隔段时间查阅出现断片的情况，笔者动手绘制了流程图以及加入源码出处的链接，可就是这样阅读量也没有那么多，真的是文章太垃圾了吗（难以接受。。哈哈），还是高处不胜寒？亦或是现在的JetPack学习热情不够高造成的吗，**有的人说现在Kotlin基本没人用，就更别说基于Kotlin的Jetpack了**，可是笔者却不这么认为，只要看了笔者前几篇文章你就会发现，现在gitthub上的App开源项目几乎清一色的是基于Kotlin+jetpack开发的，就连目前的**影梭**APP也同样在迭代最新的JetPack包。笔者在查看国内流行技术的外文博客中，有发表时间是一年甚至两年以前的，天朝的围墙虽然挡住了我们的视野，却没有挡住我们学习的热情，国外的一手资料往往能让我们更加了解，我们所欠缺的部分，学习以至于不会落后于时代。

### 正文：

> 本文基于 [MVP一键生成 Template模板开发与快速开发神器](https://blog.csdn.net/qq_20330595/article/details/79269581) 对于mvp开发模板感兴趣的可以移步该博客，本模板在此基础上修改为Mvvm模型，并替换为jetpack开发包，并尝试使用目前国际流行的开发框架,如Moshi，Koin等，是整个项目思路更加清晰，逻辑更加简洁

对于Template以及Freemaker语法本文就不做赘述，其实也没有什么好说的，了解即可。

效果图
![show](https://img-blog.csdnimg.cn/20190510112223863.gif)
第一次生成务必勾选generate Base 选项，后续生成Activi或者Fragment都无需勾选
目录结构：
![目录结构](https://img-blog.csdnimg.cn/20190510113359926.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzIwMzMwNTk1,size_16,color_FFFFFF,t_70)

关于Koin想了解朋友可以参考
[KOIN — A dependency injection framework](https://medium.com/@shinoogoyalaggarwal/koin-a-dependency-injection-framework-85ed1eb2eaa5)
他比dagger2更加简单直接

关于Databinding的使用不理解的可以参考
[新版Databinding基础教程](https://blog.csdn.net/qq_20330595/article/details/90024971)

build_gradle中包含了 携程/Room/LiveData/ViewMode等主要依赖，其他的如Paging/Worker可以自行添加到本模块当中

好了，该模板解决了Mvp的高度耦合问题是其一直被开发者所诟病的。借助于Kotlin，的函数式编程和JetPack的ViewMode开创的MvvM开发模式极大程度的降低了项目架构的复杂度，换句话说Mvp确实不符合现今的开发领域（至少Android是这样），让我们试着拥抱JetPack吧，试着去理解什么叫Android界的喷气式背包吧。


GitHub地址：
https://github.com/goodluckforme/jetpackplug