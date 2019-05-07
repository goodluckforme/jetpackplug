package ${ativityPackageName}

import android.content.pm.ActivityInfo
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import ${packageName}.R
import ${packageName}.databinding.Activity${pageName}Binding
import ${viewModelPackageName}.${pageName}ViewModel
import org.jetbrains.anko.bundleOf
import org.koin.android.ext.android.inject

class ${pageName}Activity : AppCompatActivity() {
    private lateinit var binding: Activity${pageName}Binding
    private val ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel by inject<${pageName}ViewModel>()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = Activity${pageName}Binding.inflate(layoutInflater, null, false)
        binding. ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel = ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel
        setContentView(binding.root)
    }
}