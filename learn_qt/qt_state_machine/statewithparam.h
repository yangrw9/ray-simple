#ifndef STATEWITHPARAM_H
#define STATEWITHPARAM_H

#include <QState>

class StateWithParam : public QState
{
    Q_OBJECT

Q_SIGNALS:
    //
    // Strong typed signal with parameter.
    // Different name makes Qt 5 new connect() syntax eaiser.
    //
    // Note: DO NOT connect entered() at same time.
    //      (For reson, see Qt impl source code)
    //
    void entered_bool(bool flag);
    void entered_int(int id);
    void entered_str(const QString& text);
public:
    StateWithParam(QState *parent = 0);
protected:
    virtual void onEntry ( QEvent * event );
};

#endif // STATEWITHPARAM_H
