<layout xmlns:android="http://schemas.android.com/apk/res/android">

    <data>

        <import type="${viewModelPackageName}.${pageName}ViewModel" />

        <variable
            name="${extractLetters(pageName[0]?lower_case)}${pageName?substring(1,pageName?length)}ViewModel"
            type="${pageName}ViewModel" />
    </data>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical">

    </LinearLayout>
</layout>
