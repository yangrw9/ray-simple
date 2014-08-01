#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

   QUrl source("qrc:main.qml");
//    QUrl source = QUrl::fromLocalFile("main.qml");

    ui->quickWidget->setSource(source);
}

MainWindow::~MainWindow()
{
    delete ui;
}
