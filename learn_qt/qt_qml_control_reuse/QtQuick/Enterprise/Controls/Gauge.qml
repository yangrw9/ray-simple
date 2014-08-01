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
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype Gauge
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.0
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-non-interactive
    \brief A straight gauge that displays a value within a range.

    \image gauge.png Gauge

    The Gauge control displays a value within some range along a horizontal or
    vertical axis. It can be thought of as an extension of ProgressBar,
    providing tickmarks and labels to provide a visual measurement of the
    progress.

    The minimum and maximum values displayable by the gauge can be set with the
    \l minimumValue and \l maximumValue properties.

    Example:
    \code
    Gauge {
        minimumValue: 0
        value: 50
        maximumValue: 100
        anchors.centerIn: parent
    }
    \endcode

    You can create a custom appearance for a Gauge by assigning a \l GaugeStyle.
*/

Control {
    id: gauge

    style: GaugeStyle {}

    /*!
        This property holds the smallest value displayed by the gauge.

        The default value is \c 0.
    */
    property alias minimumValue: range.minimumValue

    /*!
        This property holds the value displayed by the gauge.

        The default value is \c 0.
    */
    property alias value: range.value

    /*!
        This property holds the largest value displayed by the gauge.

        The default value is \c 100.
    */
    property alias maximumValue: range.maximumValue

    /*!
        This property determines the orientation of the gauge.

        The default value is \c Qt.Vertical.
    */
    property int orientation: Qt.Vertical

    /*!
        This property determines the alignment of each tickmark within the
        gauge. When \l orientation is \c Qt.Vertical, the valid values are:

        \list
        \li Qt.AlignLeft
        \li Qt.AlignRight
        \endlist

        Any other value will cause \c Qt.AlignLeft to be used, which is also the
        default value for this orientation.

        When \l orientation is \c Qt.Horizontal, the valid values are:

        \list
        \li Qt.AlignTop
        \li Qt.AlignBottom
        \endlist

        Any other value will cause \c Qt.AlignBottom to be used, which is also
        the default value for this orientation.
    */
    property int tickmarkAlignment: orientation == Qt.Vertical ? Qt.AlignLeft : Qt.AlignBottom

    /*!
        \internal

        TODO: finish this

        This property determines whether or not the tickmarks and their labels
        are drawn inside (over) the gauge. The value of this property affects
        \l tickmarkAlignment.
    */
    property bool __tickmarksInside: false

    /*!
        This property determines the rate at which tickmarks are drawn on the
        gauge. The lower the value, the more often tickmarks are drawn.

        The default value is \c 10.
    */
    property int tickmarkStepSize: 10

    /*!
        This property determines the amount of minor tickmarks drawn between
        each regular tickmark.

        The default value is \c 4.
    */
    property int minorTickmarkCount: 4

    /*!
        \qmlproperty font Gauge::font

        The font to use for the tickmark text.
    */
    property alias font: hiddenText.font

    Text {
        id: hiddenText
        font.pixelSize: 12
        visible: false
    }

    RangeModel {
        id: range
        minimumValue: 0
        value: 0
        maximumValue: 100
    }
}
