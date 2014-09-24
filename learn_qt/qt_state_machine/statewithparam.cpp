#include "statewithparam.h"

#include <QStateMachine>
#include <QVariant>

StateWithParam::StateWithParam(QState *parent) :
    QState (parent)
{

}

//
// 拆解 QEvent ，对于有参数的 Signal （有限的几个） 直接调用参数
//
void StateWithParam::onEntry(QEvent *event)
{
    // for QSignalTransition, dispath params directly

    QStateMachine::SignalEvent *se = dynamic_cast<QStateMachine::SignalEvent*>(event);
    if (se)
    {
        const QList<QVariant> args = se->arguments();
        if (args.size() == 1)
        {
            // Make one parameter signal strong type
            const QVariant arg1 = args.at(0);
            Q_ASSERT(arg1.isValid());

            switch( QVariant::Type type = arg1.type())
            {
            Q_UNUSED(type)
            case QVariant::Bool:
            {
                bool v = arg1.toBool();
                emit entered_bool(v);
                break;
            }
            case QVariant::String:
            {
                QString v = arg1.toString();
                emit entered_str(v);
                break;
            }
            case QVariant::Int:
            {
                int v = arg1.toInt();
                emit entered_int(v);
                break;
            }
            default:
                ;
            // bypass other arg type
            }
        }
        // bypass other arg number
    }
    //QState::onEntry(event);   // it's do nothing. arrording source code...
}


class MyTrueSignalTransition : public QSignalTransition
{
public:
    MyTrueSignalTransition(QCheckBox *check) :
        QSignalTransition(check,SIGNAL(stateChanged(int))){}
protected:
    bool eventTest(QEvent *e){
        if (!QSignalTransition::eventTest(e))
            return false;
        QStateMachine::SignalEvent *se = static_cast<QStateMachine::SignalEvent*>(e);
        return (se->arguments().at(0).toInt() == Qt::Checked);
    }
    void onTransition(QEvent * e){
        QSignalTransition::onTransition(e);
        QStateMachine::SignalEvent *se = static_cast<QStateMachine::SignalEvent*>(e);
        int InputState = se->arguments().at(0).toInt();
        qDebug()<<"Signal argument="<<InputState;
    }
};
