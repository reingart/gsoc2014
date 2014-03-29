#!/bin/sh
#
# Minimal script to start a remote debug session on a wxQT NDK android app
#
# based on ndk-gdb Copyright (C) 2010 The Android Open Source Project
# Licensed under the Apache License, Version 2.0 (the "License");
#

# configure the NDK path

ANDROID_NDK_ROOT=~/src/android-ndk-r9d
AWK_SCRIPTS=$ANDROID_NDK_ROOT/build/awk
GDB_CLIENT=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gdb

run ()
{
    echo "## COMMAND: $@"
    echo
    "$@" 2>&1
}

PACKAGE_NAME=`awk -f $AWK_SCRIPTS/extract-package-name.awk AndroidManifest.xml`
OPTION_LAUNCH=`awk -f $AWK_SCRIPTS/extract-launchable.awk AndroidManifest.xml`

##PACKAGE_NAME=org.reingart.gsoc2014 
##OPTION_LAUNCHorg.qtproject.qt5.android.bindings.QtActivity

# start the activity:

# do not use -D (to not launch JDB & avoid "Waiting for debugger to attach")
run adb shell am start -n $PACKAGE_NAME/$OPTION_LAUNCH
run adb shell sleep 2

# getpid and datadir:

#run adb shell ps
PID=`adb shell ps | awk -f $AWK_SCRIPTS/extract-pid.awk -v PACKAGE="$PACKAGE_NAME"`
DATA_DIR=/data/data/$PACKAGE_NAME #`adb shell run-as $PACKAGE_NAME /system/bin/sh -c pwd`
DEVICE_GDBSERVER=$DATA_DIR/lib/gdbserver

#echo PID=$PID DATA_DIR=$DATA_DIR DEV_GDB=$DEVICE_GDBSERVER
#echo "------------------------------------------------------------------------------------"

# start debugger server

run adb shell run-as $PACKAGE_NAME $DEVICE_GDBSERVER +debug-socket --attach $PID &

# Get the app_server binary from the device

APP_OUT=./libs/armeabi/
APP_PROCESS=$APP_OUT/app_process
#adb pull /system/bin/app_process $APP_PROCESS
echo "Pulled app_process from device/emulator."
#adb pull /system/bin/linker $APP_OUT/linker
echo "Pulled linker from device/emulator."
#adb pull /system/lib/libc.so $APP_OUT/libc.so
echo "Pulled libc.so from device/emulator."

# forward port

run adb forward tcp:1234 localfilesystem:$DATA_DIR/debug-socket

# attach the java part (avoid Waiting for debugger forever)
#JDB_PORT=65534
#run adb forward tcp:$JDB_PORT jdwp:$PID
#sleep 1
#jdb -connect com.sun.jdi.SocketAttach:hostname=localhost,port=$JDB_PORT &
sleep 1


echo "set solib-search-path $APP_OUT " > gdb.setup
echo "directory /home/reingart/src/android-ndk-r9d/platforms/android-9/arch-arm/usr/include /home/reingart/src/android-ndk-r9d/sources/android/native_app_glue .. /home/reingart/src/android-ndk-r9d/sources/cxx-stl/system /home/reingart/src/android-ndk-r9d/platforms/android-9/arch-arm/usr/lib/" >> gdb.setup 
echo "file $APP_PROCESS" >> gdb.setup 
echo "target remote :1234" >> gdb.setup

# start debugger client
$GDB_CLIENT -x gdb.setup 



