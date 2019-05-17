<?xml version="1.0"?>
<recipe>
<#if needInintBase>
<#--  Database  -->
<instantiate from="root/src/app_package/MuchKoin.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/Koin.kt" /> 
<instantiate from="root/src/app_package/database/MuchBaseDatabase.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(dataPackageName)}/BaseDatabase.kt" />

<instantiate from="root/src/app_package/database/MuchAppDatabase.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(dataPackageName)}/AppDatabase.kt" />

<instantiate from="root/src/app_package/database/MuchConverters.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(dataPackageName)}/Converters.kt" />        

<instantiate from="root/src/app_package/MuchNeededModule.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/NeededModule.kt" />

<instantiate from="root/src/app_package/MuchConstant.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(baseContractPackageName)}/Constant.kt" />

<instantiate from="root/src/app_package/MuchAbstractViewModel.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(baseContractPackageName)}/AbstractViewModel.kt" />

<instantiate from="root/src/app_package/MuchApp.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/App.kt" />

<instantiate from="root/src/app_package/MuchAppApi.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(apipackageName)}/AppApi.kt" />

<instantiate from="root/src/app_package/MuchAppService.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(apipackageName)}/AppService.kt" />

<instantiate from="root/src/app_package/MuchBaseObserver.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(apipackageName)}/BaseObserver.kt" />

<instantiate from="root/src/app_package/HttpResult.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(entityPackageName)}/HttpResult.kt" />
<instantiate from="root/src/app_package/MuchBaseActivity.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvvm/ui/base/BaseActivity.kt" />
<instantiate from="root/src/app_package/MuchBaseFragment.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(packageName)}/mvvm/ui/base/BaseFragment.kt" />
              
<instantiate from="root/src/app_package/MuchSharedPreferencesUtil.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(utilsPackageName)}/SharedPreferencesUtil.kt" />
<instantiate from="root/src/app_package/StartActivityUtils.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(utilsPackageName)}/StartActivityUtils.kt" />

<mkdir at="${muchAppOut}" />                  
<instantiate from="root/build.gradle.ftl"
                   to="${muchAppOut}/build_.gradle" />
				   				  
<instantiate from="root/gradle.properties.ftl"
                   to="${escapeXmlAttribute(topOut)}/gradle_.properties" />

<instantiate from="root/project_build.gradle.ftl"
                   to="${escapeXmlAttribute(topOut)}/build_.gradle" />

<instantiate from="root/keystore.properties.ftl"
                   to="${escapeXmlAttribute(topOut)}/keystore.properties" />

 <!-- 全部资源 -->
<copy from="root/res"
            to="${escapeXmlAttribute(resOut)}" />
<!-- libs 库 -->
<copy from="root/libs"
            to="${escapeXmlAttribute(projectOut)}/libs" />
</#if>

<#if needActivity>
    <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
</#if>

<#if needActivity && generateActivityLayout>

    <instantiate  from="root/res_template/layout/simple.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${activityLayoutName}.xml" />
</#if>

<#if needActivity>
    <instantiate from="root/src/app_package/MuchActivity.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.kt" />
    <open file="${projectOut}/src/main/java/${slashedPackageName(ativityPackageName)}/${pageName}Activity.kt" />
</#if>

<#if needFragment && generateFragmentLayout>
    <instantiate from="root/res_template/layout/simple.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${fragmentLayoutName}.xml" />
</#if>

<#if needFragment>
    <instantiate from="root/src/app_package/MuchFragment.kt.ftl"
                    to="${projectOut}/src/main/java/${slashedPackageName(fragmentPackageName)}/${pageName}Fragment.kt" />
    <open file="${projectOut}/src/main/java/${slashedPackageName(fragmentPackageName)}/${pageName}Fragment.kt" />
</#if>


<instantiate from="root/src/app_package/MuchViewModel.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(viewModelPackageName)}/${pageName}ViewModel.kt" />

<#if needDatabase>

<instantiate from="root/src/app_package/database/MuchRepository.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(repositoriesPackageName)}/${pageName}Repository.kt" />

<instantiate from="root/src/app_package/database/MuchData.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(entityPackageName)}/${pageName}Data.kt" /> 

<instantiate from="root/src/app_package/database/MuchDataDao.kt.ftl"
                   to="${projectOut}/src/main/java/${slashedPackageName(daoPackageName)}/${pageName}Dao.kt" />

<open file="${projectOut}/src/main/java/${slashedPackageName(dataPackageName)}/BaseDatabase.kt" />                           
</#if>
</recipe>
