#ifndef MYEVENT_H
#define MYEVENT_H

#include <QEvent>
#include <qstring.h>

// Concept & Define
//
// http://qt-project.org/doc/qt-4.8/qevent.html
// http://stackoverflow.com/questions/2248009/qt-defining-a-custom-event-type
//
// http://stackoverflow.com/questions/12545711/how-do-events-work-in-qt?lq=1

// Usage
//
// http://stackoverflow.com/questions/6061352/creating-a-custom-message-event-with-qt

// All-in-one simple sample (hope the link is alive)
// http://qsjming.blog.51cto.com/1159640/1084110
//

class MyEvent : public QEvent
{
public:
    //    static const QEvent::Type myType = static_cast<QEvent::Type>(QEvent::registerEventType());  // not constexpr, will C++11 be helpful ? maybe no. NO.

//    static const QEvent::Type myType = static_cast<QEvent::Type>(User + 1);  // hard-code (copy & modify of this code should think a different one)

    // better (don't care  unique integer any more), should allocate in .cpp file (C++ syntax)
    static const QEvent::Type myType; //  (1) define an integer to indentify our custom event.

    explicit MyEvent(const QString& msg);

    QString extra() const {return extra_;}
protected:
    QString extra_;  // (3) how we are different.

};

#endif // MYEVENT_H
