package ${dataPackageName}

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
<#if needDatabase>
import ${daoPackageName}.${pageName}Dao
import ${entityPackageName}.${pageName}Data
</#if>

@Database(entities = [ <#if needDatabase> (${pageName}Data::class)</#if>], version = 1, exportSchema = true)
@TypeConverters(Converters::class)
abstract class BaseDatabase : RoomDatabase() {
  <#if needDatabase>  abstract fun ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}Dao(): ${pageName}Dao</#if>
}