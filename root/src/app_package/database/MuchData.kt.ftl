package ${entityPackageName}

import androidx.room.Entity
import androidx.room.PrimaryKey
import org.threeten.bp.Instant

@Entity
data class ${pageName}Data(
    var displayName: String = "",
    var rounds: Long = 0L,
    var createdAt: Instant = Instant.now()
) {
    @PrimaryKey(autoGenerate = true)
    var id: Long = 0
}
