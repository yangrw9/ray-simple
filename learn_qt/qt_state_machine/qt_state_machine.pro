#-------------------------------------------------
#
# Project created by QtCreator 2014-09-23T09:31:50
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qt_state_machine
TEMPLATE = app

CONFIG += c++11

SOURCES += main.cpp\
        mainwindow.cpp \
    statewithparam.cpp

HEADERS  += mainwindow.h \
    statewithparam.h

FORMS    += mainwindow.ui
