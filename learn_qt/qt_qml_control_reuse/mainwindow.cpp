#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QQuickWidget>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QQuickWidget * qw = new QQuickWidget(this);
    QUrl source("qrc:main.qml");
    qw->setSource(source);

    setCentralWidget(qw);


}

MainWindow::~MainWindow()
{
    delete ui;
}
