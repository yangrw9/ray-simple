#-------------------------------------------------
#
# Project created by QtCreator 2014-05-17T15:56:39
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = learn_qt_custom_event
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    myevent.cpp

HEADERS  += mainwindow.h \
    myevent.h

FORMS    += mainwindow.ui

OTHER_FILES += \
    Readme.txt
