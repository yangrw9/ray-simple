#-------------------------------------------------
#
# Project created by QtCreator 2014-07-30T13:37:34
#
#-------------------------------------------------

QT       += core
QT       -= gui

TARGET = qt_signal_and_interface
CONFIG   += console
CONFIG   -= app_bundle
CONFIG   += c++11

TEMPLATE = app


SOURCES += main.cpp \
    fooimpl.cpp \
    foointerface.cpp \
    handlefoo.cpp

HEADERS += \
    fooimpl.h \
    foointerface.h \
    handlefoo.h

OTHER_FILES += \
    Readme.txt
