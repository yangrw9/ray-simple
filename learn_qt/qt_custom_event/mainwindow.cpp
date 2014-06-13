#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QMessageBox>
#include <QDebug>
//#include <QApplication>
//#include <QElapsedTimer>
#include <QDateTime>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
//    ui->pushButton
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::customEvent(QEvent *event)
{
    if(event->type() == MyEvent::myType)    // (1) so we are different (via forever 'integer')
    {
       MyEvent* myEvent = static_cast<MyEvent *>(event);    // (2) make it C++ safe
       // (3) C++ world open, C++ will guard us, let's do

       QString s = myEvent->extra();
       qDebug() << s;
       ui->textBrowser->setText(s);
    }
}

void MainWindow::on_pushButton_clicked()
{
//   QMessageBox::information(NULL, "Hello", "Hello World!");

// QApplication::postEvent(this, new MyEvent("We are different!"));

    //    http://stackoverflow.com/questions/244646/qt-fast-way-to-measure-time
    //    static QElapsedTimer timer;
    //    timer.start();

    // http://www.qtcentre.org/archive/index.php/t-1606.html
    // needs <windows.h>
    // LARGE_INTEGER tickPerSecond;
    // get the high resolution counter's accuracy
    //  QueryPerformanceFrequency(&tickPerSecond);

   // http://stackoverflow.com/questions/2781119/how-to-get-the-current-timestamp-in-qt
    qint64 tick = QDateTime::currentMSecsSinceEpoch();
    QString str("We are different! ");
    str += QString::number(tick);
    QApplication::postEvent(this, new MyEvent(str));

}
