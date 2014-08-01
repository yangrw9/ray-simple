#-------------------------------------------------
#
# Project created by QtCreator 2014-07-18T11:09:14
#
#-------------------------------------------------

QT       += core gui quick widgets quickwidgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qt_qml_on_qwidget
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

OTHER_FILES += \
    main.qml \
    Readme.txt

RESOURCES += \
    qml_on_qwidget.qrc

