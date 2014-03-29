gsoc2014
========

Qt proof of concept app to experiment in cross-compiling [wxQT](http://wiki.wxwidgets.org/WxQt) for Android

Build instructions:

    /home/reingart/qt/5.2.1/android_armv5/bin/qmake
    make install INSTALL_ROOT=android
    #/home/reingart/qt/5.2.1/android_armv5/bin/androiddeployqt --output android --android-platform android-10
    cd android
    ant debug


Deploy:

    /home/reingart/src/android-sdk-linux/platform-tools/adb -e install -r bin/QtApp-debug.apk
    /home/reingart/src/android-sdk-linux/platform-tools/adb -e logcat

Debug:

    cd android
    ./gdb.sh

Tested with a "Nexus One" AVD Android 2.3.3, API Level 10, CPU/ABI ARM (armeabi).

wxQt Minimal hello world dialog sample running under android:

![](https://18366829875916615714.googlegroups.com/attach/f33f364ba1c0aa0d/wxQtAndroid.png?part=4&view=1&vt=ANaJVrHaA74Ip18Ze-R3TH_XVYP97aQzqUMiUVSIJtIq-XmfKM1wBD93acw3HhPpVmeLR6InzfjLDyK1D9yIFnu1nKcgEeY3bn39ilCyhIfV6IusfGlJs-I) 

Old screenshot captures:

![](https://dl.dropboxusercontent.com/u/75600582/gsoc2014/android_screen.png)

![](https://dl.dropboxusercontent.com/u/75600582/gsoc2014/android_app.png)


