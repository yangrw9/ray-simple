#include "myevent.h"

// http://stackoverflow.com/questions/2605520/c-where-to-initialize-static-const
const QEvent::Type MyEvent::myType = static_cast<QEvent::Type>(QEvent::registerEventType()); // allocate

MyEvent::MyEvent(const QString& msg) :
    QEvent(myType)  // (2) tell QEvent, we are an unique (different) custom event.
{
    extra_ = msg;

}
