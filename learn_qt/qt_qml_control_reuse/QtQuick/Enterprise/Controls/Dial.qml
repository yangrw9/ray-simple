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
import QtQuick.Controls 1.0
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype Dial
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.0
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-interactive
    \brief A circular dial that is rotated to set a value.

    \image dial.png A Dial

    The Dial is similar to a traditional dial knob that is found on devices
    such as stereos or industrial equipment. It allows the user to specify a
    value within a range.

    Like CircularGauge, Dial can display tickmarks to give an indication of
    the current value. When a suitable stepSize is combined with
    \l {DialStyle::tickmarkStepSize}{tickmarkStepSize}, the dial "snaps" to
    each tickmark.

    You can create a custom appearance for a Dial by assigning a \l DialStyle.
*/

Control {
    id: dial
    style: DialStyle {}

    /*!
        \qmlproperty real Dial::value

        The angle of the handle along the dial, in the range of
        \c 0.0 to \c 1.0.

        The default value is \c{0.0}.
    */
    property alias value: range.value

    /*!
        \qmlproperty real Dial::minimumValue

        The smallest value allowed by the dial.

        The default value is \c{0.0}.

        \sa value, maximumValue
    */
    property alias minimumValue: range.minimumValue

    /*!
        \qmlproperty real Dial::maximumValue

        The largest value allowed by the dial.

        The default value is \c{1.0}.

        \sa value, minimumValue
    */
    property alias maximumValue: range.maximumValue

    /*!
        \qmlproperty real Dial::hovered

        This property holds whether the button is being hovered.
    */
    readonly property alias hovered: mouseArea.containsMouse

    /*!
        \qmlproperty real Dial::stepSize

        The default value is \c{0.0}.
    */
    property alias stepSize: range.stepSize

    /*!
        \internal
        Determines whether the dial can be freely rotated past the zero marker.

        The default value is \c false.
    */
    property bool __wrap: false

    /*!
        This property specifies whether the dial should gain active focus when
        pressed.

        The default value is \c false.

        \sa pressed
    */
    property bool activeFocusOnPress: false

    /*!
        \qmlproperty bool Dial::pressed

        Returns \c true if the dial is pressed.

        \sa activeFocusOnPress
    */
    readonly property alias pressed: mouseArea.pressed

    /*!
        \since 1.1

        This property determines whether or not the dial displays tickmarks.

        The default value is \c true.
    */
    property bool tickmarksVisible: true

    RangeModel {
        id: range
        minimumValue: 0.0
        maximumValue: 1.0
        stepSize: 0
        value: 0
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        parent: __panel.background.parent
        anchors.fill: parent

        onPositionChanged: {
            if (pressed) {
                value = valueFromPoint(mouseX, mouseY)
            }
        }
        onPressed: {
            value = valueFromPoint(mouseX, mouseY)
             if (activeFocusOnPress) dial.forceActiveFocus()
        }

        function bound(val) { return Math.max(minimumValue, Math.min(maximumValue, val)); }

        function valueFromPoint(x, y)
        {
            var yy = height / 2.0 - y;
            var xx = x - width / 2.0;
            var angle = (xx || yy) ? Math.atan2(yy, xx) : 0;

            if (angle < Math.PI/ -2)
                angle = angle + Math.PI * 2;

            var range = maximumValue - minimumValue;
            var value;
            if (__wrap)
                value = (minimumValue + range * (Math.PI * 3 / 2 - angle) / (2 * Math.PI));
            else
                value = (minimumValue + range * (Math.PI * 4 / 3 - angle) / (Math.PI * 10 / 6));

            return bound(value)
        }
    }
}
