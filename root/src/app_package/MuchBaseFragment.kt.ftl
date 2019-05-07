package ${packageName}.mvp.ui.base
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment


abstract class BaseFragment : Fragment() {

    var isViewPrepared: Boolean = false
    var hasFetchData: Boolean = false
    var rootView: View? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        if (null == rootView) rootView = View.inflate(activity, getLayoutRes(), null)
        return rootView
    }

    protected abstract fun getLayoutRes(): Int

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        Log.i("BaseFragment", "=============onViewCreated=============" + this)
        super.onViewCreated(view, savedInstanceState)
        attachView()
        isViewPrepared = true
        lazyFetchDataIfPrepared()
    }

    abstract fun attachView()

    abstract fun detachView()

    override fun setUserVisibleHint(isVisibleToUser: Boolean) {
        super.setUserVisibleHint(isVisibleToUser)
        if (isVisibleToUser) {
            lazyFetchDataIfPrepared()
        }
    }

    private fun lazyFetchDataIfPrepared() {
        // 用户可见fragment && 没有加载过数据 && 视图已经准备完毕
        Log.i(
            "BaseFragment",
            "userVisibleHint=============<#noparse>$userVisibleHint======hasFetchData======$hasFetchData======isViewPrepared=============$isViewPrepared${javaClass.simpleName}</#noparse>"
        )
        if (userVisibleHint && !hasFetchData && isViewPrepared) {
            hasFetchData = true
            initData()
        }
    }

    /**
     * 初始化方法
     */
    protected open fun initData() {}

    override fun onDestroyView() {
        super.onDestroyView()
        detachView()
//        hasFetchData = false
//        isViewPrepared = false
    }

    /**
     * 只有show 和 hide 才会调用
     */
    override fun onHiddenChanged(hidden: Boolean) {
        super.onHiddenChanged(hidden)
        Log.i("BaseFragment", "onHiddenChanged========" + this + hidden)
    }
}
