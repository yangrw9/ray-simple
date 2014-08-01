
将 QML 控件 放到 QWidget 界面中

https://qt-project.org/doc/qt-4.7/qml-integration.html
  Integrating QML Code with Existing Qt UI Code
  (这篇文章似乎很老了 Qt 4.7   QDeclarativeView  QDeclarativeComponent)

http://www.ics.com/blog/combining-qt-widgets-and-qml-qwidgetcreatewindowcontainer
  Combining Qt Widgets and QML with QWidget::createWindowContainer()
  (这篇文章给了个集成例子 Qt 5.1  似乎只有从 5.1 开始才能好好的集成)
  Qt 5.1 introduces a new method in the QWidget class called createWindowContainer().
  It allows embedding a QWindow (such as a QQuickView) into a QWidget-based application.
  This allows combining both QML and widgets in the same application, something that was not possible with Qt 5.0.

Qt 5.3 中（安装的是 5.3 v，以前不知道）发现一个例子 qt quick widgets


  This example is referencing Qt Quick Widgets example.


Raymond
2014/8/1

