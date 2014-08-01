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
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls 1.1
import QtQuick.Enterprise.Controls.Private 1.0

/*!
    \qmltype GaugeStyle
    \inqmlmodule QtQuick.Enterprise.Controls.Styles
    \since QtQuick.Enterprise.Controls.Styles 1.0
    \ingroup enterprisecontrolsstyling
    \brief Provides custom styling for Gauge.

    You can create a custom gauge by replacing the following delegates:
    \list
    \li \l background
    \li valueBar
    \li tickmarkLabel
    \endlist
*/

Style {
    id: gaugeStyle

    QtObject {
        id: privateScope

        function toPixels(percentage) {
            return control.orientation === Qt.Vertical ? percentage * control.width : percentage * control.height;
        }

        function toPixelsW(percentageOfWidth) {
            return control.orientation === Qt.Vertical
                ? percentageOfWidth * control.width : percentageOfWidth * control.height;
        }

        function toPixelsH(percentageOfHeight) {
            return control.orientation === Qt.Vertical
                ? percentageOfHeight * control.height : percentageOfHeight * control.width;
        }
    }

    /*!
        This defines the text of each tickmark label on the gauge.
    */
    property Component tickmarkLabel: Text {
        text: styleData.value
        font: control.font
        color: "#c8c8c8"
        antialiasing: true
    }

    /*!
        The background of the gauge, displayed behind the \l valueBar.

        By default, no background is defined.
    */
    property Component background

    /*!
        Each tickmark displayed by the gauge.
    */
    property Component tickmark: Rectangle {
        // Flooring prevents inconsistent sizes under small bounding rects.
        color: "#c8c8c8"
    }

    /*!
        Each minor tickmark displayed by the gauge.
    */
    property Component minorTickmark: Rectangle {
        color: "#c8c8c8"
    }

    /*!
        The bar that represents the value of the gauge.
    */
    property Component valueBar: Rectangle {
        color: "#00bbff"
    }

    /*!
        The bar that represents the foreground of the gauge.

        This component is drawn above every other component.
    */
    property Component foreground: Canvas {
        readonly property real xCenter: width / 2
        readonly property real yCenter: height / 2
        property real shineLength: (control.orientation === Qt.Vertical ? height : width) * 0.95

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            ctx.beginPath();
            ctx.rect(0, 0, width, height);

            var gradient;
            if (control.orientation === Qt.Vertical) {
                gradient = ctx.createLinearGradient(0, yCenter, width, yCenter);
            } else {
                gradient = ctx.createLinearGradient(xCenter, 0, xCenter, height);
            }

            gradient.addColorStop(0, Qt.rgba(1, 1, 1, 0.08));
            gradient.addColorStop(1, Qt.rgba(1, 1, 1, 0.20));
            ctx.fillStyle = gradient;
            ctx.fill();
        }
    }

    /*! \internal */
    property Component panel: Item {
        id: panelComponent
        implicitWidth: control.orientation === Qt.Vertical ? tickmarkLabel.implicitWidth + 10 + margin : 200
        implicitHeight: control.orientation === Qt.Vertical ? 200 : tickmarkLabel.implicitHeight + 10 + margin

        readonly property real margin: 4

        Item {
            id: container

            width: control.orientation === Qt.Vertical ? parent.implicitWidth : parent.width
            height: control.orientation === Qt.Vertical ? parent.height : parent.implicitHeight
            anchors.centerIn: parent

            Item {
                id: valueBarItem

                // We need to account for the tickmark offset here..
                width: control.orientation === Qt.Vertical ? parent.width * 0.3 : parent.width - (tickmarkLabel.tickmarkOffset * 2 - 2)
                height: control.orientation === Qt.Vertical ? parent.height - (tickmarkLabel.tickmarkOffset * 2 - 2) : parent.height * 0.3
                // .. so we also must account for the positioning.
                x: {
                    var xPos = 0;
                    if (control.orientation === Qt.Horizontal) {
                        xPos = parent.width / 2 - width / 2;
                    } else {
                        xPos = control.tickmarkAlignment === Qt.AlignRight ? 0 : parent.width - width;
                    }
                    xPos;
                }
                y: {
                    var yPos = 0;
                    if (control.orientation === Qt.Vertical) {
                        yPos = parent.height / 2 - height / 2;
                    } else {
                        yPos = control.tickmarkAlignment === Qt.AlignTop ? parent.height - height : 0;
                    }
                    yPos;
                }

                Loader {
                    id: backgroundLoader
                    sourceComponent: background
                    anchors.fill: parent
                }

                Loader {
                    id: valueBarLoader
                    sourceComponent: valueBar

                    property real valueAsPercentage: (control.value - control.minimumValue) / (control.maximumValue - control.minimumValue)

                    x: 0
                    y: control.orientation === Qt.Vertical ? parent.height - height : 0
                    width: control.orientation === Qt.Horizontal ? valueAsPercentage * parent.width : parent.width
                    height: control.orientation === Qt.Vertical ? valueAsPercentage * parent.height : parent.height
                }
            }
            TickmarkLabel {
                id: tickmarkLabel
                stepSize: control.tickmarkStepSize
                minorTickmarkCount: control.minorTickmarkCount
                orientation: control.orientation
                minimumValue: control.minimumValue
                maximumValue: control.maximumValue

                width: control.orientation === Qt.Vertical ? parent.width * 0.7 : parent.width
                height: control.orientation === Qt.Vertical ? parent.height : parent.height * 0.7

                alignment: {
                    var align;
                    if (control.__tickmarksInside) {
                        align = control.tickmarkAlignment;
                    } else {
                        // We have to reverse the alignment of the TickmarkLabel.
                        if (control.orientation === Qt.Vertical) {
                            if (control.tickmarkAlignment === Qt.AlignLeft) {
                                align = Qt.AlignRight;
                            } else {
                                align = Qt.AlignLeft;
                            }
                        } else {
                            if (control.tickmarkAlignment === Qt.AlignTop) {
                                align = Qt.AlignBottom;
                            } else {
                                align = Qt.AlignTop;
                            }
                        }
                    }
                    align;
                }

                x: {
                    var xPos = 0;
                    if (orientation === Qt.Vertical) {
                        if (control.tickmarkAlignment !== Qt.AlignLeft) {
                            xPos = !control.__tickmarksInside ? valueBarItem.x + valueBarItem.width + margin : valueBarItem.x + valueBarItem.width - width;
                        } else if (control.tickmarkAlignment !== Qt.AlignRight) {
                            xPos = !control.__tickmarksInside ? valueBarItem.x - width - margin : valueBarItem.x;
                        }
                    }
                    xPos;
                }

                y: {
                    var yPos = 0;
                    if (orientation === Qt.Horizontal) {
                        if (control.tickmarkAlignment !== Qt.AlignTop) {
                            yPos = !control.__tickmarksInside ? valueBarItem.y + valueBarItem.height + margin : valueBarItem.y + valueBarItem.height - height;
                        } else if (control.tickmarkAlignment !== Qt.AlignBottom) {
                            yPos = !control.__tickmarksInside ? valueBarItem.y - height - margin : valueBarItem.y;
                        }
                    }
                    yPos;
                }

                font: control.font

                style: TickmarkLabelStyle {
                    tickmarkLabel: gaugeStyle.tickmarkLabel
                    tickmark: gaugeStyle.tickmark
                    minorTickmark: gaugeStyle.minorTickmark
                }
            }
            Loader {
                id: foregroundLoader
                sourceComponent: foreground
                anchors.fill: valueBarItem
            }
        }
    }
}
