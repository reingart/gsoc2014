#-------------------------------------------------
#
# Project created by QtCreator 2014-03-19T22:49:47
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = gsoc2014
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

CONFIG += mobility
MOBILITY = 

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

# fix bits/c++config.h: No such file or directory
DEPENDPATH = /home/reingart/src/android-ndk-r9d/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi/include/
