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
// Workaround for QTBUG-37751; we need this import for RangeModel, although we shouldn't.
import QtQuick.Controls 1.0
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype CircularGauge
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.0
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-non-interactive
    \brief A gauge that displays a value within a range along an arc.

    \image circulargauge.png CircularGauge

    The CircularGauge is similar to traditional mechanical gauges that use a
    needle to display a value from some input, such as the speed of a vehicle or
    air pressure, for example.

    The minimum and maximum values displayable by the gauge can be set with the
    \l minimumValue and \l maximumValue properties. The angle at which these
    values are displayed can be set with the
    \l {CircularGaugeStyle::minimumValueAngle}{minimumValueAngle} and
    \l {CircularGaugeStyle::maximumValueAngle}{maximumValueAngle} properties of
    CircularGaugeStyle.

    Example:
    \code
    CircularGauge {
        value: accelerating ? maximumValue : 0
        anchors.centerIn: parent

        property bool accelerating: false

        Keys.onSpacePressed: accelerating = true
        Keys.onReleased: {
            if (event.key === Qt.Key_Space) {
                accelerating = false;
                event.accepted = true;
            }
        }

        Component.onCompleted: forceActiveFocus()

        Behavior on value {
            NumberAnimation {
                duration: 1000
            }
        }
    }
    \endcode

    You can create a custom appearance for a CircularGauge by assigning a
    \l CircularGaugeStyle.
*/

Control {
    id: circularGauge

    style: CircularGaugeStyle {}

    /*!
        \qmlproperty real CircularGauge::minimumValue

        This property holds the smallest value displayed by the gauge.
    */
    property alias minimumValue: range.minimumValue

    /*!
        \qmlproperty real CircularGauge::maximumValue

        This property holds the largest value displayed by the gauge.
    */
    property alias maximumValue: range.maximumValue

    /*!
        This property holds the current value displayed by the gauge, which will
        always be between \l minimumValue and \l maximumValue, inclusive.
    */
    property alias value: range.value

    /*!
        \qmlproperty real CircularGauge::stepSize

        This property holds the size of the value increments that the needle
        displays.

        For example, when stepSize is \c 10 and value is \c 0, adding \c 5 to
        \l value will have no visible effect on the needle, although \l value
        will still be incremented. Adding an extra \c 5 to \l value will then
        cause the needle to point to \c 10.
    */
    property alias stepSize: range.stepSize

    RangeModel {
        id: range
        minimumValue: 0
        maximumValue: 100
        stepSize: 0
        value: minimumValue
    }
}
