package ${daoPackageName}

import androidx.lifecycle.LiveData
import androidx.room.*
import ${entityPackageName}. ${pageName}Data


@Dao
interface ${pageName}Dao {

    @Query("SELECT count(id) FROM ${pageName}Data")
    fun count(): Int

    @Query("SELECT count(id) FROM ${pageName}Data")
    fun has(): Boolean

    @Query("SELECT * FROM ${pageName}Data WHERE id = :id")
    fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}DataByIdNow(id: Long): ${pageName}Data?

    @Query("SELECT * FROM ${pageName}Data WHERE id = :id")
    fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}DataById(id: Long): LiveData<${pageName}Data?>

    @Query("SELECT * FROM ${pageName}Data ORDER BY createdAt DESC")
    fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Datas(): LiveData<List<${pageName}Data>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(vararg ${pageName}Data: ${pageName}Data): Array<Long>

    @Query("DELETE FROM ${pageName}Data WHERE id = :id")
    fun deleteById(id: Long)

    @Delete
    fun delete(${pageName}Data: ${pageName}Data)

    @Query("DELETE FROM ${pageName}Data")
    fun deleteAll()

}