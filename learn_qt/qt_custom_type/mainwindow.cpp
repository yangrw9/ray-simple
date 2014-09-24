#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    qRegisterMetaType<MyParam>("MyParam"); // For (A)
    connect(this, SIGNAL(BlaBla(MyParam)), this, SLOT(on_blabla(MyParam)), Qt::QueuedConnection); // (A) queued signal and slot connections
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    MyParam p;
    p.op = 13;
    p.x = 1;
    p.y = 9;
    emit BlaBla(p);
}

void MainWindow::on_blabla(MyParam param) // (A) if queued (otherwise NOT needed)
{
    qDebug() << "op:" << param.op ;
    qDebug() << "x: " << param.x ;
    qDebug() << "y: " << param.y ;
}

void MainWindow::ProcessVar(QVariant var)
{
    int tid = var.userType();

    const int id = qMetaTypeId<MyParam>();  // (B) otherwise compile error
    const int id2 = qMetaTypeId<My2>();
    if ( id == tid);
    {
        MyParam p = var.value<MyParam>();
        qDebug() << "In variant: " << p.op << ": " << p.x << ", " << p.y;
    }

    int l;
    l = 1; // set breakpoint here, for view id, id2 (in debugger)
}

void MainWindow::on_pushButton_2_clicked()
{
    MyParam p;
    p.op = 222;
    p.x = 21;
    p.y = 29;

    QVariant var;
    var.setValue(p);
    ProcessVar(var);  // (B) pass custom type in variant
}
