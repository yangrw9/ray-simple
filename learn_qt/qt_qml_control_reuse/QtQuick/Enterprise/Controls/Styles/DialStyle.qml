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
import QtQuick.Enterprise.Controls.Private 1.0

/*!
    \qmltype DialStyle
    \inqmlmodule QtQuick.Enterprise.Controls.Styles
    \since QtQuick.Enterprise.Controls.Styles 1.0
    \ingroup enterprisecontrolsstyling
    \brief Provides custom styling for Dial.

    You can create a custom dial by replacing the following delegates:
    \list
        \li \l background
    \endlist
*/

Style {
    id: dialStyle

    /*!
        \since 1.1

        The distance from the center of the dial to the outer edge of the dial.

        This property is useful for determining the size of the various
        components of the style, in order to ensure that they are scaled
        proportionately when the dial is resized.
    */
    readonly property real outerRadius: Math.min(control.height, control.width)

    /*!
        \since 1.1

        The interval at which tickmarks are displayed.

        For example, if this property is set to \c 10,
        control.minimumValue to \c 0, and control.maximumValue to \c 100,
        the tickmarks displayed will be 0, 10, 20, etc., to 100, along
        the circumference of the dial.
    */
    property real tickmarkStepSize: 1

    /*!
        \since 1.1

        The distance in pixels from the outside of the dial (outerRadius) at
        which the outermost point of the tickmark line is drawn.
    */
    property real tickmarkInset: 0


    /*!
        \since 1.1

        The amount of tickmarks displayed by the dial, calculated from
        \l tickmarkStepSize and the control's
        \l {Dial::minimumValue}{minimumValue} and
        \l {Dial::maximumValue}{maximumValue}.

        \sa minorTickmarkCount
    */
    readonly property int tickmarkCount: control.__panel.circularTickmarkLabel.tickmarkCount

    /*!
        \since 1.1

        The amount of minor tickmarks between each tickmark.

        \sa tickmarkCount
    */
    property int minorTickmarkCount: 0

    /*!
        \since 1.1

        The distance in pixels from the outside of the dial (outerRadius) at
        which the outermost point of the minor tickmark line is drawn.
    */
    property real minorTickmarkInset: 0

    /*!
        \since 1.1

        The distance in pixels from the outside of the dial (outerRadius) at
        which the center of the value marker text is drawn.
    */
    property real labelInset: 0

    /*!
        \since 1.1

        The interval at which tickmark labels are displayed.

        For example, if this property is set to \c 10 (the default),
        control.minimumValue to \c 0, and control.maximumValue to \c 100, the
        tickmark labels displayed will be 0, 10, 20, etc., to 100,
        along the circumference of the dial.
    */
    property real labelStepSize: tickmarkStepSize

    /*!
        \since 1.1

        The amount of tickmark labels displayed by the dial, calculated from
        \l labelStepSize and the control's
        \l {Dial::minimumValue}{minimumValue} and
        \l {Dial::maximumValue}{maximumValue}.

        \sa tickmarkCount, minorTickmarkCount
    */
    readonly property int labelCount: control.__panel.circularTickmarkLabel.labelCount

    /*! \internal */
    readonly property real __tickmarkRadius: outerRadius * 0.03

    /*!
        The background of the dial.

        The dial and its handle are both drawn here.
    */
    property Component background: Item {
        Canvas {
            id: backgroundCanvas
            anchors.fill: parent

            readonly property real xCenter: width / 2
            readonly property real yCenter: height / 2

            onPaint: {
                var ctx = getContext("2d");
                __backgroundHelper.paintBackground(ctx);
            }

            HandleStyleHelper {
                id: handleHelper
            }

            Canvas {
                id: handleCanvas
                x: pos.x - width / 2
                y: pos.y - height / 2
                width: __backgroundHelper.handleWidth
                height: __backgroundHelper.handleHeight
                property point pos: styleData.positionForValue(control.value, 0.7, control.inverted)

                onPaint: {
                    var ctx = getContext("2d");
                    handleHelper.paintHandle(ctx, 1, 1, width - 2, height - 2);
                }
            }
        }
    }

    /*!
        \since 1.1

        This component defines each individual tickmark. The position of each
        tickmark is already set; only the size needs to be specified.
    */
    property Component tickmark: Rectangle {
        width: outerRadius * 0.015 + (styleData.index === 0 || styleData.index === tickmarkCount ? 1 : (styleData.index) / tickmarkCount) * __tickmarkRadius * 0.75
        height: width
        radius: height / 2
        color: styleData.index === 0 ? "transparent" : Qt.rgba(0, 0, 0, 0.266)
        antialiasing: true
        border.width: styleData.index === 0 ? Math.max(1, outerRadius * 0.0075) : 0
        border.color: Qt.rgba(0, 0, 0, 0.266)
    }

    /*!
        \since 1.1

        This component defines each individual minor tickmark. The position of
        each minor tickmark is already set; only the size needs to be specified.

        By default, no minor tickmark is defined.
    */
    property Component minorTickmark

    /*!
        \since 1.1

        This defines the text of each tickmark label on the dial.

        By default, no label is defined.
    */
    property Component tickmarkLabel

    /*! \internal */
    property Component panel: Item {
        implicitWidth: backgroundHelper.implicitWidth
        implicitHeight: backgroundHelper.implicitHeight

        property alias background: backgroundLoader.item
        property alias circularTickmarkLabel: circularTickmarkLabel_

        CircularButtonStyleHelper {
            id: backgroundHelper
            control: dialStyle.control
            property color zeroMarkerColor: "#a8a8a8"
            property color zeroMarkerColorTransparent: "transparent"
            property real zeroMarkerLength: outerArcLineWidth * 1.25
            property real zeroMarkerWidth: outerArcLineWidth * 0.3

            property real handleRadius: radius * 0.175
            property real handleWidth: handleRadius * 2
            property real handleHeight: handleRadius * 2
            /*!
                Distance from the center of the dial to the center of the handle.
            */
            property real handleOffset: radius - handleRadius * 1.5

            smallestAxis: Math.min(backgroundLoader.width, backgroundLoader.height) - __tickmarkRadius * 4
        }

        Loader {
            id: backgroundLoader
            sourceComponent: dialStyle.background
            width: outerRadius
            height: width
            anchors.centerIn: parent

            property alias __backgroundHelper: backgroundHelper
            property QtObject styleData: QtObject {
                property real __radians: {
                    if (control.__wrap) {
                        return (control.value - control.minimumValue) /
                                (control.maximumValue - control.minimumValue) *
                                (Utils.pi2) + backgroundHelper.zeroAngle;
                    } else {
                        return - (Math.PI * 8 - (control.value - control.minimumValue) * 10 *
                                  Math.PI / (control.maximumValue - control.minimumValue)) / 6;
                    }
                }

                /*!
                    Returns a position along a circumference (\a value) where the distance
                    from the center of the dial is \a offset.
                */
                function positionForValue(value, offset) {
                    return Utils.centerAlongCircle(backgroundLoader.width / 2, backgroundLoader.height / 2,
                                                   0, 0, __radians , offset * (backgroundHelper.smallestAxis / 2))
                }
            }
        }

        CircularTickmarkLabel {
            id: circularTickmarkLabel_
            anchors.fill: backgroundLoader

            minimumValue: control.minimumValue
            maximumValue: control.maximumValue
            stepSize: control.stepSize
            minimumValueAngle: 210
            maximumValueAngle: 150
            tickmarkStepSize: dialStyle.tickmarkStepSize
            tickmarkInset: dialStyle.tickmarkInset
            minorTickmarkCount: dialStyle.minorTickmarkCount
            minorTickmarkInset: dialStyle.minorTickmarkInset
            labelInset: dialStyle.labelInset
            labelStepSize: dialStyle.labelStepSize

            style: CircularTickmarkLabelStyle {
                tickmark: dialStyle.control.tickmarksVisible ? dialStyle.tickmark : null
                minorTickmark: dialStyle.control.tickmarksVisible ? dialStyle.minorTickmark : null
                tickmarkLabel: dialStyle.control.tickmarksVisible ? dialStyle.tickmarkLabel : null
            }
        }
    }
}
