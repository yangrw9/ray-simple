/****************************************************************************
**
** Copyright (C) 2014 Digia Plc
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

/*
    \l minimumValueAngle and \l maximumValueAngle must be in the range from
    -360 to 360 degrees. The absolute value of the range created by
    \l minimumValueAngle and \l maximumValueAngle must be less than or equal
    to 360 degrees.
*/

Control {
    style: CircularTickmarkLabelStyle {}

    property alias minimumValue: range.minimumValue

    property alias maximumValue: range.maximumValue

    property alias stepSize: range.stepSize

    RangeModel {
        id: range
        minimumValue: 0
        maximumValue: 100
        stepSize: 0
        // Not used.
        value: minimumValue
    }

    /*!
        This property determines the angle at which the first tickmark is drawn.
    */
    property real minimumValueAngle: 215

    /*!
        This property determines the angle at which the last tickmark is drawn.
    */
    property real maximumValueAngle: 145

    /*!
        The range between \l minimumValueAngle and \l maximumValueAngle, in
        degrees. This value will always be positive.
    */
    readonly property real angleRange: {
        var a = maximumValueAngle - minimumValueAngle;
        return a >= 0 ? a : 360 + a;
    }

    /*!
        The interval at which tickmarks are displayed.
    */
    property real tickmarkStepSize: 10

    /*!
        The distance in pixels from the outside of the control (outerRadius) at
        which the outermost point of the tickmark line is drawn.
    */
    property real tickmarkInset: 0.0

    /*!
        The amount of tickmarks displayed.
    */
    readonly property int tickmarkCount: __tickmarkCount

    /*!
        The amount of minor tickmarks between each tickmark.
    */
    property int minorTickmarkCount: 4

    /*!
        The distance in pixels from the outside of the control (outerRadius) at
        which the outermost point of the minor tickmark line is drawn.
    */
    property real minorTickmarkInset: 0.0

    /*!
        The distance in pixels from the outside of the control (outerRadius) at
        which the center of the value marker text is drawn.
    */
    property real labelInset: __style.__protectedScope.toPixels(0.19)

    /*!
        The interval at which tickmark labels are displayed.
    */
    property real labelStepSize: tickmarkStepSize

    /*!
        The amount of tickmark labels displayed.
    */
    readonly property int labelCount: (maximumValue - minimumValue) / labelStepSize + 1

    /*! \internal */
    readonly property real __tickmarkCount: tickmarkStepSize > 0 ? (maximumValue - minimumValue) / tickmarkStepSize + 1 : 0
}
