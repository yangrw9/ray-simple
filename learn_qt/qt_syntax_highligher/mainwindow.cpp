#include "mainwindow.h"
#include "ui_mainwindow.h"

#include "my_hightligher.h"
#include <qtextedit.h>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QTextEdit *editor = new QTextEdit(this);
    editor->setFontPointSize(24);
    setCentralWidget(editor);

    MyHightligher *hi = new MyHightligher(editor->document());


}

MainWindow::~MainWindow()
{
    delete ui;
}
