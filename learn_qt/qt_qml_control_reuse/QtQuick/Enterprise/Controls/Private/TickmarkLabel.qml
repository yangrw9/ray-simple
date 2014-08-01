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
    \internal

    The TickmarkLabel is a utility control that draws a series of tickmarks and
    text along an axis, marking values.

    Example:
    \code
    TickmarkLabel {
        minimumValue: 50
        maximumValue: 180
        stepSize: 20
    }
    \endcode

    A TickmarkLabel can be laid out vertically (the default) or horizontally, by
    setting the \l orientation property to \c Qt.Vertical or \c Qt.Horizontal,
    respectively.

    \image tickmarklabel-horizontal.png A horizontal TickmarkLabel
    A horizontal TickmarkLabel

    The alignment of the tickmarks within the label can be configured by setting
    the \l tickmarkAlignment property.

    You can create a custom appearance for a TickmarkLabel by assigning a
    \l TickmarkLabelStyle.
*/

Control {
    id: tickmarkLabel

    style: TickmarkLabelStyle {}

    /*!
        This property holds the smallest value displayed by the label.

        The default value is \c 0.
    */
    property real minimumValue: 0

    /*!
        This property holds the largest value displayed by the label.

        The default value is \c 100.
    */
    property real maximumValue: 100

    /*!
        This property determines the orientation of the label.

        Changing this property changes the alignment to ensure that it is valid.
        For example, if this property is set to \c Qt.Horizontal, the alignment
        will be changed to the default for that orientation: \c Qt.AlignTop.

        The default value is \c Qt.Vertical.
    */
    property int orientation: Qt.Vertical

    /*!
        This property determines the alignment of each tickmark within the
        label. When \l orientation is \c Qt.Vertical, the valid values are:

        \list
        \li Qt.AlignLeft
        \li Qt.AlignRight
        \endlist

        TODO: not true. add __alignment for actual value.
        Any other value will cause \c Qt.AlignLeft to be used, which is the
        default value for this orientation.

        When \l orientation is \c Qt.Horizontal, the valid values are:

        \list
        \li Qt.AlignTop
        \li Qt.AlignBottom
        \endlist

        TODO: not true. add __alignment for actual value.
        Any other value will cause \c Qt.AlignTop to be used, which is
        the default value for this orientation.
    */
    property int alignment: orientation == Qt.Vertical ? Qt.AlignLeft : Qt.AlignTop

    /*!
        This property determines the rate at which tickmarks are drawn on the
        label. The lower the value, the more often tickmarks are drawn.

        The default value is \c 10.
    */
    property int stepSize: 10

    /*!
        This property determines the amount of minor tickmarks drawn between
        each regular tickmark.

        The default value is \c 4.
    */
    property int minorTickmarkCount: 4

    /*!
        The distance from each end of the gauge at which the first and last
        tickmarks are drawn.
    */
    property real tickmarkOffset: defaultTickmarkOffset

    /*!
        \qmlproperty font TickmarkLabel::font

        The font to use for the tickmark text.
    */
    property alias font: defaultText.font

    /*!
        The default tickmark offset. This is equal to half the height
        of the maximum tickmark text, or half the width if the orientation is
        \c Qt.Horizontal. If specifying a custom tickmarkOffset, it is
        recommended to add this property to it.
    */
    readonly property real defaultTickmarkOffset: orientation === Qt.Vertical
        ? __defaultText.height / 2 : __defaultText.width / 2

    /*! \internal */
    function __toPixels(percentage) {
        return orientation === Qt.Vertical ? percentage * height : percentage * width;
    }

    /*! \internal */
    property alias __defaultText: defaultText
    Text {
        id: defaultText
        text: maximumValue
        visible: false
    }
}
