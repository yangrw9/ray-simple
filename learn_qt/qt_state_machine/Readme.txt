
// QSignalTransition * addTransition ( QObject * sender, const char * signal, QAbstractState * target )

Qt5 的 QState::addTransition 只是在当 signal 触发时，转移状态，

1、不能传递 signal 发生时的参数
2、不能根据 signal 发生时的参数，决定是否跳转


本工程中的 StateWithParam 试图解决问题 1


下面的代码试图解决问题 2 （部分）


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


Raymond
2014/9/24



