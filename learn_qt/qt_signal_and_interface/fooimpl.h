#ifndef FOOIMPL_H
#define FOOIMPL_H

#include "foointerface.h"
#include <qobject.h>

Q_DECLARE_INTERFACE(FooInterface, "FooInterface")

class FooImpl : public QObject, public FooInterface
{
    Q_OBJECT
    Q_INTERFACES(FooInterface)

public:
    void MakeHappend();
signals:
    /*virtual*/ void SomeHappen(); // 不用 virtual ，避免出现  Warning: Signals cannot be declared virtual （这警告好假）
};

#endif // FOOIMPL_H
