#ifndef MYPARAM_H
#define MYPARAM_H

#include <QMetaType>

class MyParam
{
public:
    MyParam();
    int op;
    int x;
    int y;
};

Q_DECLARE_METATYPE(MyParam)     // For (B)

struct My2
{
    int a;
    int b;
};
Q_DECLARE_METATYPE(My2)

#endif // MYPARAM_H
