#!/bin/sh
#
# Minimal script to start a remote debug session on a wxQT NDK android app
#
# based on ndk-gdb Copyright (C) 2010 The Android Open Source Project
# Licensed under the Apache License, Version 2.0 (the "License");
#

# configure your paths

PROGDIR=`dirname $0`
PROGDIR=`cd $PROGDIR && pwd -P`
HOME=/home/reingart
ANDROID_NDK_ROOT=$HOME/src/android-ndk-r9d/
ANDROID_SDK_ROOT=$HOME/src/android-sdk-linux/
QT_ROOT=$HOME/qt
WX_QT_BUILD=$HOME/src/wxQT/android
AWK_SCRIPTS=$ANDROID_NDK_ROOT/build/awk
GDB_CLIENT=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gdb

run ()
{
    echo "## COMMAND: $@"
    echo
    "$@" 2>&1
}

# first get the application name to debug:

PACKAGE_NAME=`awk -f $AWK_SCRIPTS/extract-package-name.awk AndroidManifest.xml`
OPTION_LAUNCH=`awk -f $AWK_SCRIPTS/extract-launchable.awk AndroidManifest.xml`

##PACKAGE_NAME=org.reingart.gsoc2014 
##OPTION_LAUNCHorg.qtproject.qt5.android.bindings.QtActivity

# start the activity:

# do not use -D (to not launch JDB & avoid "Waiting for debugger to attach")
run adb shell am start -n $PACKAGE_NAME/$OPTION_LAUNCH
run adb shell sleep 2

# get the PID and data dir from the running app:

#run adb shell ps
PID=`adb shell ps | awk -f $AWK_SCRIPTS/extract-pid.awk -v PACKAGE="$PACKAGE_NAME"`
DATA_DIR=/data/data/$PACKAGE_NAME #`adb shell run-as $PACKAGE_NAME /system/bin/sh -c pwd`
DEVICE_GDBSERVER=$DATA_DIR/lib/gdbserver

# start debugger server

run adb shell run-as $PACKAGE_NAME $DEVICE_GDBSERVER +debug-socket --attach $PID &

# Get the app_server binary and libraries from the device

APP_OUT=./libs/armeabi/
APP_PROCESS=$APP_OUT/app_process
#adb pull /system/bin/app_process $APP_PROCESS
echo "Pulled app_process from device/emulator."
#adb pull /system/bin/linker $APP_OUT/linker
echo "Pulled linker from device/emulator."
adb pull /system/lib/libc.so $APP_OUT/libc.so
echo "Pulled libc.so from device/emulator."
if [ ! -d /tmp/system_lib ]
then
    adb pull /system/lib /tmp/system_lib
    echo "Pulled system lib folder from device/emulator."
fi

# forward port

run adb forward tcp:1234 localfilesystem:$DATA_DIR/debug-socket

# attach the java part (avoid Waiting for debugger forever)
#JDB_PORT=65534
#run adb forward tcp:$JDB_PORT jdwp:$PID
#sleep 1
#jdb -connect com.sun.jdi.SocketAttach:hostname=localhost,port=$JDB_PORT &
sleep 1

# create sourced command file (similar to the one created by ndk-build):

echo "target remote :1234" > gdb.setup
echo "file $APP_PROCESS" >> gdb.setup 
echo -n "set solib-search-path $QT_ROOT/5.2.1/android_armv5/lib/:" >> gdb.setup
echo -n "$QT_ROOT/5.2.1/android_armv5//plugins/platforms/:" >> gdb.setup
echo -n "$QT_ROOT/5.2.1/android_armv5//plugins/platforms/android:" >> gdb.setup
echo -n "$ANDROID_NDK_ROOT/platforms/android-10/arch-arm/usr/lib:" >> gdb.setup
echo -n "/tmp/system_lib:" >> gdb.setup
echo -n "/tmp/system_lib/hw:" >> gdb.setup  # this one for gralloc.default.so
echo    "$PROGDIR/$APP_OUT" >> gdb.setup
echo "directory $ANDROID_NDK_ROOT/platforms/android-9/arch-arm " >> gdb.setup
echo "directory $WX_QT_BUILD " >> gdb.setup
echo "sharedlibrary" >> gdb.setup
echo "set auto-solib-add on" >> gdb.setup
 
# start debugger client
$GDB_CLIENT -x gdb.setup 



