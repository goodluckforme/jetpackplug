package ${repositoriesPackageName}

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Transformations
import ${dataPackageName}.AppDatabase
import ${entityPackageName}.${pageName}Data

import kotlinx.coroutines.*
import org.koin.standalone.KoinComponent
import org.koin.standalone.inject

interface ${pageName}Repository {
    suspend fun new(displayName: String = "Untitled"): Deferred<${pageName}Data>
    suspend fun delete(data: ${pageName}Data)
    suspend fun delete(id: Long)
    fun watch${pageName}(${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Id: Long)
    fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Data(): LiveData<${pageName}Data?>
    fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Datas(): LiveData<List<${pageName}Data>>
}

class ${pageName}RepositoryImpl : ${pageName}Repository, KoinComponent {

    private val db by inject<AppDatabase>()
    private val dao = db.getDatabase().${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Dao()

    private val ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}sLiveData = Transformations.switchMap(db.isDatabaseCreated()) { created ->
        if (created) {
            dao.${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Datas()
        } else {
            MutableLiveData()
        }
    }

    private val ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}IdLiveData = MutableLiveData<Long>()


    private val ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}LiveData = Transformations.switchMap(db.isDatabaseCreated()) { created ->
        if (created) {
            Transformations.switchMap(${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}IdLiveData) { id ->
                dao.${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}DataById(id)
            }
        } else {
            MutableLiveData()
        }
    }

    override suspend fun new(displayName: String): Deferred<${pageName}Data> {
        return GlobalScope.async(Dispatchers.IO) {
            //val dao = db.getDatabase().${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Dao()
            val ids = dao.insertAll(${pageName}Data(displayName))
            return@async dao.${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}DataByIdNow(ids.first()) ?: throw RuntimeException("${pageName} cannot be null")
        }
    }

    override suspend fun delete(${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}: ${pageName}Data) {
        GlobalScope.launch(Dispatchers.IO) {
            //val dao = db.getDatabase().${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Dao()
            dao.delete(${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)})
        }
    }

    override suspend fun delete(id: Long) {
        GlobalScope.launch(Dispatchers.IO) {
            //val dao = db.getDatabase().${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Dao()
            dao.deleteById(id)
        }
    }

    override fun watch${pageName}(${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Id: Long) {
        ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}IdLiveData.postValue(${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Id)
    }
    override fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Data(): LiveData<${pageName}Data?> = ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}LiveData
    override fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Datas(): LiveData<List<${pageName}Data>> = ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}sLiveData

}