gsoc2014
========

Qt proof of concept app to experiment in cross-compiling [wxQT](http://wiki.wxwidgets.org/WxQt) for Android

Build instructions:

    /home/reingart/qt/5.2.1/android_armv5/bin/qmake
    make install INSTALL_ROOT=build
    /home/reingart/qt/5.2.1/android_armv5/bin/androiddeployqt --output build --android-platform android-10


Deploy:

    /home/reingart/src/android-sdk-linux/platform-tools/adb -e install -r build/bin/QtApp-debug.apk
    /home/reingart/src/android-sdk-linux/platform-tools/adb -e logcat

Debug:

    cd android
    ./gdb.sh

Tested with a "Nexus One" AVD Android 2.3.3, API Level 10, CPU/ABI ARM (armeabi).
Screenshot captures:

![](https://dl.dropboxusercontent.com/u/75600582/gsoc2014/android_screen.png)

![](https://dl.dropboxusercontent.com/u/75600582/gsoc2014/android_app.png)


