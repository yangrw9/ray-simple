#
# http://blog.csdn.net/dbzhang800/article/details/6765117
# Raymond: The 'SUBDIRS' project in Qt is a logical concept.
#          Analogy with 'Solution' in Visual Studio,
#          or 'workspace' in Eclipse.
#          (Pass test under Qt 5.2.1)
#

TEMPLATE = subdirs

SUBDIRS += \
    qtprj1 \
    ../qt-prj2 \
    ../qt-prj2/qt-prj2-1.pro \
    ./cur.pro
