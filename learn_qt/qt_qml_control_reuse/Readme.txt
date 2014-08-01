
复用 QML Control （以企业版控件为例子, latest version in 2014/8/1 ）

最简单的复用方法是，将控件复制到（当前运行的）Qt 安装，形成如下目录

/home/ray/bin/Qt5.3.1/5.3/gcc_64/qml/QtQuick/Enterprise/Controls/

比例啰嗦的（逐项目复用是）

o 编译时  .pro 文件中添加 QML_IMPORT_PATH = $$PWD
o 设计器  （这咋整……设计器不灵啊，工具栏有，画出的界面里木有，QT_PLUGIN_PATH 运行前？……）
o 运行时  构建成功自定义命令 cp -r %{sourceDir}/QtQuick %{buildDir}/QtQuick


Raymond
2014/8/1

