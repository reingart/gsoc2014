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

![](https://mail-attachment.googleusercontent.com/attachment/u/0/?ui=2&ik=67e6ef997a&view=att&th=14507a6f03e588a5&attid=0.1&disp=safe&realattid=f_htb60k6x0&zw&saduie=AG9B_P8cRMRx973NZWcLA937-ar-&sadet=1396065693170&sads=cGFAlxqhecvi5RkG8YW-R-6OUwI&sadssc=1) 

Old screenshot captures:

![](https://dl.dropboxusercontent.com/u/75600582/gsoc2014/android_screen.png)

![](https://dl.dropboxusercontent.com/u/75600582/gsoc2014/android_app.png)


