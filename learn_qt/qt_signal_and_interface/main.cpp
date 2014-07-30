#include <QCoreApplication>

#include <qdebug.h>
#include "fooimpl.h"
#include "handlefoo.h"

int main(int /*argc*/, char */*argv*/[])
{
    FooImpl fimpl;
    FooInterface * f = &fimpl;
    HandleFoo h;
    QObject::connect(dynamic_cast<QObject*>(f), SIGNAL(SomeHappen()), &h, SLOT(HandleHappen()) );
    QObject::connect(dynamic_cast<QObject*>(f), SIGNAL(SomeHappen()), &h, SLOT(Handle2()) );
    fimpl.MakeHappend();
    fimpl.MakeHappend();

    // http://www.qtcentre.org/threads/49190-Can-i-call-a-Signal-normally
    //  ... the "emit" or "Q_EMIT" pseudo-keyword is #defined away
    //  ... So, in short, you are always calling the signal directly.
    // 我去，emit 就是个空定义，可以直接上 signal 啊…… （好像 boost 里类似货是这么上的……）
    //
    fimpl.SomeHappen();
    qDebug() << "Program end.\n";


//    QCoreApplication a(argc, argv);

//    return a.exec();
}
