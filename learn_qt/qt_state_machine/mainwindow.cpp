#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>

#include <QStateMachine>
#include <statewithparam.h>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QStateMachine *m = new QStateMachine(this);
    StateWithParam * swp1 = new StateWithParam(m);
    StateWithParam * swp2 = new StateWithParam(m);
    //m->addState(swp1);
    //m->addState(swp2);
    m->setInitialState(swp1);
    m->start();

    swp1->addTransition(ui->checkBox, SIGNAL(stateChanged (int)), swp2);
    swp2->addTransition(ui->checkBox, SIGNAL(stateChanged (int)), swp2);
//    swp2->addTransition(ui->checkBox, &QCheckBox::stateChanged, swp2); // not valid

    connect(swp2, &StateWithParam::entered_int, [this](int v) { qDebug() << "this is " << v; ui->label->setText(QString::number(v));});

    //    connect(swp2, SIGNAL(entered(int)), this, SLOT(aaa(int)));
    //    connect(swp, static_cast<void (StateWithParam::*)(int)>(&StateWithParam::entered), [](int v) { qDebug() << "this is " << v;});
}

MainWindow::~MainWindow()
{
    delete ui;
}

//void MainWindow::aaa(int arg1)
//{
//    qDebug() << "in state machie" << arg1;
//}

//void MainWindow::on_checkBox_stateChanged(int arg1)
//{

//    //qDebug() << arg1;
//}

