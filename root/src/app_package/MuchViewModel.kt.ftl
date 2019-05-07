package ${viewModelPackageName}

import androidx.lifecycle.MutableLiveData
import ${apipackageName}.AppApi
import ${baseContractPackageName}.AbstractViewModel

class ${pageName}ViewModel(val appApi: AppApi) : AbstractViewModel() {
    val uiData = MutableLiveData<Any>()
}

