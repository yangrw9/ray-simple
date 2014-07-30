#ifndef HANDLEFOO_H
#define HANDLEFOO_H

#include <QObject>

class HandleFoo : public QObject
{
    Q_OBJECT
public:
    explicit HandleFoo(QObject *parent = 0);

signals:

public slots:
    void HandleHappen();
    void Handle2();
};

#endif // HANDLEFOO_H
