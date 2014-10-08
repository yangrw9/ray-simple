#include <QApplication>
#include <QDialog>
#include <QHBoxLayout>
#include <QTextEdit>

#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QDialog* dialog = new QDialog();

    QHBoxLayout* layout = new QHBoxLayout(dialog);
    QTextEdit* widget = new QTextEdit(dialog);  // parent-child
    layout->addWidget(widget);
    dialog->setLayout(layout);

    //dialog->show(); // modaless

    dialog->exec();  // modal dialog
    qDebug() << widget->toPlainText();

    //************************************************
    // NOTES for findChild()
    //
    // o. widget->setObjectName("txt"); // Optional
    // o. parent-child is key point
    // o. Q_DECLARE_METATYPE  is not required (and not possible) for custom Widget
    //

    // NOT care layout
    QLayout* lay2 = dialog->layout();
    QTextEdit * txt2 = lay2->findChild<QTextEdit*>(); // == null
    const QObjectList &list =  lay2->children();      //  == 0 items

    // CARE dialog ()
    QTextEdit* edit = dialog->findChild<QTextEdit*>(); // != null
    qDebug() << "via child" << edit->toPlainText();
    //
    //************************************************

    return 0; // we just end in main thread
    // return app.exec(); // if so, app will not terminate
}
