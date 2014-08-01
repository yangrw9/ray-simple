/****************************************************************************
**
** Copyright (C) 2013 Digia Plc
** All rights reserved.
** For any questions to Digia, please use contact form at http://qt.digia.com
**
** This file is part of the QtQuick Enterprise Controls Add-on.
**
** $QT_BEGIN_LICENSE$
** Licensees holding valid Qt Commercial licenses may use this file in
** accordance with the Qt Commercial License Agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.
**
** If you have questions regarding the use of this file, please use
** contact form at http://qt.digia.com
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls 1.1

Style {
    id: handleStyle
    property alias handleColorTop: __helper.handleColorTop
    property alias handleColorBottom: __helper.handleColorBottom
    property alias handleColorBottomStop: __helper.handleColorBottomStop

    HandleStyleHelper {
        id: __helper
    }

    property Component handle: Item {
        implicitWidth: 50
        implicitHeight: 50

        Canvas {
            id: handleCanvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                __helper.paintHandle(ctx);
            }
        }
    }

    property Component panel: Item {
        Loader {
            id: handleLoader
            sourceComponent: handle
            anchors.fill: parent
        }
    }
}
