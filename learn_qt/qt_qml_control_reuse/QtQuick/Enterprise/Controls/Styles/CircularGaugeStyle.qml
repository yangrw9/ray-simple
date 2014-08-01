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
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls 1.1
import QtQuick.Enterprise.Controls.Styles 1.1
import QtQuick.Enterprise.Controls.Private 1.0

/*!
    \qmltype CircularGaugeStyle
    \inqmlmodule QtQuick.Enterprise.Controls.Styles
    \since QtQuick.Enterprise.Controls.Styles 1.0
    \ingroup enterprisecontrolsstyling
    \brief Provides custom styling for CircularGauge.

    You can create a custom circular gauge by replacing the following delegates:
    \list
        \li \l background
        \li \l tickmark
        \li \l minorTickmark
        \li \l tickmarkLabel
        \li \l needle
        \li \l foreground
    \endlist

    Below is an example that changes the needle to a basic orange \l Rectangle:
    \code
    CircularGauge {
        style: CircularGaugeStyle {
            needle: Rectangle {
                y: outerRadius * 0.15
                width: outerRadius * 0.03
                height: outerRadius * 0.9
                antialiasing: true
                color: Qt.rgba(0.66, 0.3, 0, 1)
            }
        }
    }
    \endcode

    The result:
    \image circulargauge-needle-example-2.png CircularGaugeStyle example

    \l minimumValueAngle and \l maximumValueAngle must be in the range from
    -360 to 360 degrees. The absolute value of the range created by
    \l minimumValueAngle and \l maximumValueAngle must be less than or equal
    to 360 degrees.

    \sa {Styling Qt Quick Enterprise Controls#styling-circulargauge}{Styling
    CircularGauge}
*/

Style {
    id: circularGaugeStyle

    /*!
        The distance from the center of the gauge to the outer edge of the
        gauge.

        This property is useful for determining the size of the various
        components of the style, in order to ensure that they are scaled
        proportionately when the gauge is resized.
    */
    readonly property real outerRadius: Math.min(control.width, control.height) * 0.5

    /*!
        This property determines the minimum angle of the gauge.

        The angle set affects the following components of the gauge:
        \list
            \li The angle of the needle
            \li The position of the tickmarks
        \endlist

        The default value is \c 215.
    */
    property real minimumValueAngle: 215

    /*!
        This property determines the maximum angle of the gauge.

        The angle set affects the following components of the gauge:
        \list
            \li The angle of the needle
            \li The position of the tickmarks
        \endlist

        The default value is \c 145.
    */
    property real maximumValueAngle: 145

    /*!
        The range between \l minimumValueAngle and \l maximumValueAngle, in
        degrees. This value will always be positive.
    */
    readonly property real angleRange: control.__panel.circularTickmarkLabel.angleRange

    /*!
        This property holds the rotation of the needle in degrees.
    */
    property real needleRotation: {
        var percentage = (control.value - control.minimumValue) / (control.maximumValue - control.minimumValue);
        minimumValueAngle + percentage * angleRange;
    }

    /*!
        The interval at which tickmarks are displayed.

        For example, if this property is set to \c 10 (the default),
        control.minimumValue to \c 0, and control.maximumValue to \c 100,
        the tickmarks displayed will be 0, 10, 20, etc., to 100,
        around the gauge.
    */
    property real tickmarkStepSize: 10

    /*!
        The distance in pixels from the outside of the gauge (outerRadius) at
        which the outermost point of the tickmark line is drawn.
    */
    property real tickmarkInset: 0


    /*!
        The amount of tickmarks displayed by the gauge, calculated from
        \l tickmarkStepSize and the control's
        \l {CircularGauge::minimumValue}{minimumValue} and
        \l {CircularGauge::maximumValue}{maximumValue}.

        \sa minorTickmarkCount
    */
    readonly property int tickmarkCount: control.__panel.circularTickmarkLabel.tickmarkCount

    /*!
        The amount of minor tickmarks between each tickmark.

        The default value is \c 4.

        \sa tickmarkCount
    */
    property int minorTickmarkCount: 4

    /*!
        The distance in pixels from the outside of the gauge (outerRadius) at
        which the outermost point of the minor tickmark line is drawn.
    */
    property real minorTickmarkInset: 0

    /*!
        The distance in pixels from the outside of the gauge (outerRadius) at
        which the center of the value marker text is drawn.
    */
    property real labelInset: __protectedScope.toPixels(0.19)

    /*!
        The interval at which tickmark labels are displayed.

        For example, if this property is set to \c 10 (the default),
        control.minimumValue to \c 0, and control.maximumValue to \c 100, the
        tickmark labels displayed will be 0, 10, 20, etc., to 100,
        around the gauge.
    */
    property real labelStepSize: tickmarkStepSize

    /*!
        The amount of tickmark labels displayed by the gauge, calculated from
        \l labelStepSize and the control's
        \l {CircularGauge::minimumValue}{minimumValue} and
        \l {CircularGauge::maximumValue}{maximumValue}.

        \sa tickmarkCount, minorTickmarkCount
    */
    readonly property int labelCount: control.__panel.circularTickmarkLabel.labelCount

    property QtObject __protectedScope: QtObject {
        /*!
            Converts a value expressed as a percentage of \l outerRadius to
            a pixel value.
        */
        function toPixels(percentageOfOuterRadius) {
            return percentageOfOuterRadius * outerRadius;
        }
    }

    /*!
        The background of the gauge.

        The background fills the entire gauge; if you'd like to center something
        rather than have it fill the gauge, make it a child of an Item:

        \code
        background: Item {
            Image {
                source: "image.png"
                anchors.centerIn: parent
            }
        }
        \endcode

        By default, there is no background defined.
    */
    property Component background

    /*!
        This component defines each individual tickmark. The position of each
        tickmark is already set; only the size needs to be specified.
    */
    property Component tickmark: Rectangle {
        width: outerRadius * 0.02
        antialiasing: true
        height: outerRadius * 0.06
        color: "#c8c8c8"
    }

    /*!
        This component defines each individual minor tickmark. The position of
        each minor tickmark is already set; only the size needs to be specified.
    */
    property Component minorTickmark: Rectangle {
        width: outerRadius * 0.01
        antialiasing: true
        height: outerRadius * 0.03
        color: "#c8c8c8"
    }

    /*!
        This defines the text of each tickmark label on the gauge.
    */
    property Component tickmarkLabel: Text {
        font.pixelSize: Math.max(6, __protectedScope.toPixels(0.12))
        text: styleData.value
        color: "#c8c8c8"
        antialiasing: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    /*!
        The needle that points to the gauge's current value.

        This component is drawn below the \l foreground component.

        The style expects the needle to be pointing up at a rotation of \c 0,
        in order for the rotation to be correct. For example:

        \image circulargauge-needle.png CircularGauge's needle

        When defining your own needle component, the only properties that the
        style requires you to set are the \c width and \c height.

        Optionally, you can set \c x and \c y to change the needle's
        transform origin. Setting the \c x position can be useful for needle
        images where the needle is not centered exactly horizontally. Setting
        the \c y position allows you to make the base of the needle "hang" over
        the center of the gauge.

        \sa {Styling Qt Quick Enterprise Controls#styling-circulargauge-needle
        }{Styling CircularGauge's needle}
    */
    property Component needle: Item {
        width: __protectedScope.toPixels(0.08)
        height: 0.9 * outerRadius

        Image {
            anchors.fill: parent
            source: "images/needle.png"
        }
    }

    /*!
        The foreground of the gauge. This component is drawn above all others.

        Like \l background, the foreground component fills the entire gauge.

        By default, the knob of the gauge is defined here.
    */
    property Component foreground: Item {
        Image {
            source: "images/knob.png"
            anchors.centerIn: parent
            scale: {
                var idealHeight = __protectedScope.toPixels(0.2);
                var originalImageHeight = sourceSize.height;
                idealHeight / originalImageHeight;
            }
        }
    }

    /*! \internal */
    property Component panel: Item {
        id: panelItem
        implicitWidth: 250
        implicitHeight: 250

        property alias background: backgroundLoader.item
        property alias circularTickmarkLabel: circularTickmarkLabel_

        Loader {
            id: backgroundLoader
            sourceComponent: circularGaugeStyle.background
            width: outerRadius * 2
            height: outerRadius * 2
            anchors.centerIn: parent
        }

        CircularTickmarkLabel {
            id: circularTickmarkLabel_
            anchors.fill: backgroundLoader

            minimumValue: control.minimumValue
            maximumValue: control.maximumValue
            stepSize: control.stepSize
            minimumValueAngle: circularGaugeStyle.minimumValueAngle
            maximumValueAngle: circularGaugeStyle.maximumValueAngle
            tickmarkStepSize: circularGaugeStyle.tickmarkStepSize
            tickmarkInset: circularGaugeStyle.tickmarkInset
            minorTickmarkCount: circularGaugeStyle.minorTickmarkCount
            minorTickmarkInset: circularGaugeStyle.minorTickmarkInset
            labelInset: circularGaugeStyle.labelInset
            labelStepSize: circularGaugeStyle.labelStepSize

            style: CircularTickmarkLabelStyle {
                tickmark: circularGaugeStyle.tickmark
                minorTickmark: circularGaugeStyle.minorTickmark
                tickmarkLabel: circularGaugeStyle.tickmarkLabel
            }
        }

        Loader {
            id: needleLoader
            sourceComponent: circularGaugeStyle.needle
            transform: [
                Rotation {
                    angle: needleRotation
                    origin.x: needleLoader.width / 2
                    origin.y: needleLoader.height
                },
                Translate {
                    x: panelItem.width / 2 - needleLoader.width / 2
                    y: panelItem.height / 2 - needleLoader.height
                }
            ]
        }

        Loader {
            id: foreground
            sourceComponent: circularGaugeStyle.foreground
            anchors.fill: backgroundLoader
        }
    }
}
