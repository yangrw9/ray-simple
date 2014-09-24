#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include "myparam.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
signals:

    void BlaBla(MyParam param);

private slots:
    void on_pushButton_clicked();
    void on_pushButton_2_clicked();

    void on_blabla(MyParam param);


private:
    void ProcessVar(QVariant var);

    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
