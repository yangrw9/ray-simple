#-------------------------------------------------
#
# Project created by QtCreator 2014-07-31T16:10:38
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qt_syntax_highligher
TEMPLATE = app
CONFIG += c++11

SOURCES += main.cpp\
        mainwindow.cpp \
    my_hightligher.cpp

HEADERS  += mainwindow.h \
    my_hightligher.h

FORMS    += mainwindow.ui
