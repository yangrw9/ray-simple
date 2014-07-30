#include "handlefoo.h"
#include <qdebug.h>

HandleFoo::HandleFoo(QObject *parent) :
    QObject(parent)
{
}

void HandleFoo::HandleHappen()
{
    qDebug() << "Yes, I handlled! \n";
}

void HandleFoo::Handle2()
{
    qDebug() << "I'm 2 2 2 so 2, not 3! \n";
}
