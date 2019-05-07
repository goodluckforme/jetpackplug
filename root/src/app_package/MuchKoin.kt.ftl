package ${packageName}
import ${viewModelPackageName}.${pageName}ViewModel
import org.koin.android.ext.koin.androidContext
import org.koin.android.viewmodel.ext.koin.viewModel
import org.koin.dsl.module.module

//viewModel { MainViewModel(get(),androidContext()) }
//viewModel { params -> GameViewModel(params.component1(), get(), get()) }
val appModule = module {
    <#include "./MuchCurrentViewModel.ftl">
}