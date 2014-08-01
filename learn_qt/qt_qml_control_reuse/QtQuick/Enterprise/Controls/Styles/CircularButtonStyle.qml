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
import QtQuick.Controls.Styles 1.0
import QtQuick.Enterprise.Controls.Styles 1.1
import QtQuick.Enterprise.Controls.Private 1.0

ButtonStyle {
    id: buttonStyle

    label: Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font.pixelSize: __buttonHelper.textFontSize
        color: control.pressed || control.checked ? __buttonHelper.textColorDown : __buttonHelper.textColorUp
        styleColor: control.pressed || control.checked ? __buttonHelper.textRaisedColorDown : __buttonHelper.textRaisedColorUp
        style: Text.Raised
    }

    /*! \internal */
    property alias __buttonHelper: buttonHelper

    CircularButtonStyleHelper {
        id: buttonHelper
        control: buttonStyle.control
    }

    background: Item {
        // TODO: base these off the size of the text
        implicitWidth: 75
        implicitHeight: 75
        Canvas {
            id: backgroundCanvas
            anchors.fill: parent

            Connections {
                target: control
                onPressedChanged: backgroundCanvas.requestPaint()
            }

            onPaint: {
                var ctx = getContext("2d");
                __buttonHelper.paintBackground(ctx);
            }
        }
    }
}
