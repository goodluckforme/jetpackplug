package ${fragmentPackageName}

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import ${packageName}.databinding.Fragment${pageName}Binding
import ${viewModelPackageName}.${pageName}ViewModel
import org.koin.android.viewmodel.ext.android.viewModel

class ${pageName}Fragment : Fragment() {
    private lateinit var binding: Fragment${pageName}Binding
    val ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel: ${pageName}ViewModel by viewModel()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = Fragment${pageName}Binding.inflate(inflater, container, false)
        binding. ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel = ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel
        binding.setLifecycleOwner(viewLifecycleOwner)
        ${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel.uiData.observe(viewLifecycleOwner,
            Observer<Any> { it ->
               
            })
        binding.executePendingBindings()
        return binding.root
    }

}