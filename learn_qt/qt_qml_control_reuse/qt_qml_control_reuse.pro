#-------------------------------------------------
#
# Project created by QtCreator 2014-08-01T15:05:31
#
#-------------------------------------------------

QT       += core gui quick widgets quickwidgets

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = qt_qml_control_reuse
TEMPLATE = app

#QT_PLUGIN_PATH = $$PWD/QtQuick/Enterprise/Controls/
QML_IMPORT_PATH = $$PWD

SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

OTHER_FILES += \
    main.qml \
    Readme.txt

RESOURCES += \
    qml_control_reuse.qrc
