#-------------------------------------------------
#
# Project created by QtCreator 2014-03-27T23:08:24
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = gsoc2014
TEMPLATE = app

#LIBS += -lpthread
INCLUDEPATH += /home/reingart/src/wxWidgets/include/

# configuration for wxQt 2.9 (desktop):

#LIBS += -lwx_qtu_xrc-2.9 -lwx_qtu_html-2.9 -lwx_qtu_qa-2.9 -lwx_qtu_adv-2.9 -lwx_qtu_core-2.9 -lwx_baseu_xml-2.9 -lwx_baseu_net-2.9 -lwx_baseu-2.9
#LIBS += -L/home/reingart/src/wxWidgets/bld5/lib
#INCLUDEPATH += /home/reingart/src/wxWidgets/bld5/lib/wx/include/qt-unicode-2.9/ /home/reingart/src/wxWidgets/include/
#DEFINES += _FILE_OFFSET_BITS=64 WXUSINGDLL __WXQT__

# configuration for wxQt 2.9 (android):

LIBS += /home/reingart/src/wxWidgets/android/lib/libwx_qtu_qa-2.9-arm-linux-androideabi.a /home/reingart/src/wxWidgets/android/lib/libwx_qtu_adv-2.9-arm-linux-androideabi.a /home/reingart/src/wxWidgets/android/lib/libwx_qtu_core-2.9-arm-linux-androideabi.a /home/reingart/src/wxWidgets/android/lib/libwx_baseu-2.9-arm-linux-androideabi.a
LIBS += -L/home/reingart/src/wxWidgets/android/lib
INCLUDEPATH += /home/reingart/src/wxWidgets/android/lib/wx/include/arm-linux-androideabi-qt-unicode-static-2.9
DEFINES += __WXQT__

SOURCES += minimal.cpp

HEADERS  +=

CONFIG += mobility
CONFIG += debug
MOBILITY = 



