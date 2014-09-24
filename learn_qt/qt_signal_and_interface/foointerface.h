#ifndef FOOINTERFACE_H
#define FOOINTERFACE_H
//#include <qobject.h>

/*
o. 可以在接口内使用 signals (帖子说 signals 这货其实只是个宏替换……代码也如是）
o. 声明接口用 Q_DECLARE_INTERFACE
o. 实现接口用 Q_INTERFACES
o. 绑定接口中的 signal 用 dynamic_cast<QObject*>()
*/
// http://stackoverflow.com/questions/17943496/declare-abstract-signal-in-interface-class/
//
// http://stackoverflow.com/questions/18742138/qt-interfaces-and-signal-definitions
// http://stackoverflow.com/questions/3259728/using-qt-signals-and-slots-with-multiple-inheritance
//
// http://www.d34dl0ck.me/2013/06/mastering-interfaces-with-qt.html

class FooInterface
{
public:
    virtual ~FooInterface(){}
//signals: // not nessary
    virtual void SomeHappen() = 0;
};

//Q_DECLARE_INTERFACE(FooInterface, "FooInterface")


#endif // FOOINTERFACE_H
