
Custom Type & QMetaType

用户定义类型（如自己定义的 class 等）用参与 Qt 的类型系统，需要注册

A. qRegisterMetaType() since the names are resolved at runtime.
   1. queued signal and slot connections
   2. property system

B. Q_DECLARE_METATYPE()
   3. all template based functions

C. （不必要）
   4. 非 queued 类型的 signal and slot connections （如 Qt::DirectConnection）
      不必要使用  qRegisterMetaType() 注册


Raymond
2014/9/24
