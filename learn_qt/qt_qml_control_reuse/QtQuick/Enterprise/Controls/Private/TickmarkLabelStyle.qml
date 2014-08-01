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
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype TickmarkLabelStyle
    \internal
    \brief Provides custom styling for TickmarkLabel.

    You can create a custom tickmark label by replacing the following delegates:
    \list
        \li tickmark
        \li minorTickmark
        \li tickmarkLabel
    \endlist
*/

Style {
    id: tickmarkLabelStyle

    QtObject {
        id: privateScope

        readonly property int tickmarkCount: (control.maximumValue - control.minimumValue) / control.stepSize;
        readonly property real tickmarkDistance: effectiveArea / tickmarkCount
        readonly property real minorTickmarkDistance: tickmarkDistance / (control.minorTickmarkCount + 1);
        /*!
            The margin between the tickmarks and their text.
        */
        property real tickmarkTextMargin: 4

        /*!
            The length of each tickmark.

            On a vertical gauge, this is measured along the X axis.
            On a horizontal gauge, this is measured along the Y axis.

            \omit The length of each tickmark must be the same so that we can
            determine the location of the text.
        */
        property real tickmarkLength: 14

        /*!
            The width of each tickmark.

            On a vertical gauge, this is measured along the Y axis.
            On a horizontal gauge, this is measured along the X axis.

            \omit The width of each tickmark must be the same so that they are
            distributed equally across the gauge.
        */
        property real tickmarkWidth: 2

        /*!
            The length of each minor tickmark.

            On a vertical gauge, this is measured along the X axis.
            On a horizontal gauge, this is measured along the Y axis.
        */
        property real minorTickmarkLength: 8

        /*!
            The width of each minor tickmark.

            On a vertical gauge, this is measured along the Y axis.
            On a horizontal gauge, this is measured along the X axis.

            \omit The width of each tickmark must be the same so that they are
            distributed equally across the gauge.
        */
        property real minorTickmarkWidth: 1

        /*!
            Avoids text and markers at the top and bottom/left and right
            being clipped. This is the region within which painting should be
            done, with the exception of the first and last markers/text, as they
            will be centered over the edges of this area.
        */
        readonly property real effectiveArea: control.orientation === Qt.Vertical
             ? control.height - Math.max(tickmarkWidth, control.tickmarkOffset * 2)
             : control.width - Math.max(tickmarkWidth, control.tickmarkOffset * 2)

        readonly property real relevantSize: control.orientation === Qt.Vertical ? control.height : control.width

        function toPixelsW(percentageOfWidth) {
            return control.orientation === Qt.Vertical
                ? percentageOfWidth * control.width : percentageOfWidth * control.height;
        }

        function toPixelsH(percentageOfHeight) {
            return control.orientation === Qt.Vertical
                ? percentageOfHeight * control.height : percentageOfHeight * control.width;
        }

        /*!
            Returns the marker text that should be displayed based on
            \a markerPos (\c 0 to \c 1.0).
        */
        function markerTextFromPos(markerPos) {
            // We currently don't support decimals. If support is added, the width
            // calculation code needs to be updated.
            return Math.floor(markerPos * (control.maximumValue - control.minimumValue) + control.minimumValue);
        }
    }

    /*!
        Each tickmark displayed by the gauge.
    */
    property Component tickmark: Rectangle {
        color: "#cccccc"
    }

    /*!
        Each minor tickmark displayed by the gauge.
    */
    property Component minorTickmark: Rectangle {
        color: "#cccccc"
    }

    /*!
        This component is responsible for drawing each tickmark's corresponding
        label.

        The \c styleData.value property is provided as an indication of the
        value that the tickmark marks.
        The \c styleData.index property is the index of the tickmark
        component.
    */
    property Component tickmarkLabel: Text {
        text: styleData.value
        font: control.font
        color: "#cccccc"
    }

    /*! \internal */
    property Component panel: Item {
        implicitWidth: rawWidth + extraWidth
        implicitHeight: rawHeight + extraHeight

        readonly property real rawWidth: control.orientation === Qt.Vertical ? privateScope.tickmarkLength + control.__defaultText.width + privateScope.tickmarkTextMargin : 200
        readonly property real rawHeight: control.orientation === Qt.Vertical ? 200 : privateScope.tickmarkLength + control.__defaultText.width + privateScope.tickmarkTextMargin

        readonly property real extraWidth: control.orientation === Qt.Horizontal ? Math.max(privateScope.tickmarkWidth, control.tickmarkOffset * 2) : 0
        readonly property real extraHeight: control.orientation === Qt.Vertical ? Math.max(privateScope.tickmarkWidth, control.tickmarkOffset * 2) : 0

        Item {
            id: effectiveBounds
            anchors.centerIn: parent
            width: control.orientation === Qt.Horizontal ? parent.width - extraWidth : rawWidth
            height: control.orientation === Qt.Horizontal ? rawHeight : parent.height - extraHeight

            Repeater {
                id: tickmarkRepeater
                model: privateScope.tickmarkCount + 1
                delegate: Loader {
                    id: tickmarkDelegateLoader

                    x: {
                        if (control.orientation === Qt.Vertical) {
                            if (control.alignment === Qt.AlignRight) {
                                return effectiveBounds.width - width;
                            }
                            // Either it's invalid or Qt.AlignLeft (which is the
                            // default when an invalid alignment is specified).
                            return 0;
                        }
                        // Horizontal.
                        // We rotate the tickmark around the top left, so in order to have it
                        // centered over the edge of the container, we need to push it to the side after rotating it.
                        var rotationAjustment = control.alignment === Qt.AlignTop ? height / 2 : -height / 2;
                        return index * privateScope.tickmarkDistance + rotationAjustment;
                    }
                    y: {
                        if (control.orientation === Qt.Horizontal) {
                            if (control.alignment === Qt.AlignBottom) {
                                // We rotate the tickmark -90 degrees in this scenario,
                                // so it swings back around and anchored itself to the edge for us.
                                return effectiveBounds.height;
                            }
                            // Either it's invalid or Qt.AlignTop (which is the
                            // default when an invalid alignment is specified).
                            return 0;
                        }
                        // Vertical.
                        return effectiveBounds.height - index * privateScope.tickmarkDistance - height / 2;
                    }

                    width: privateScope.tickmarkLength
                    height: privateScope.tickmarkWidth

                    transformOrigin: Qt.TopLeftCorner
                    rotation: control.orientation === Qt.Horizontal ? (control.alignment === Qt.AlignBottom ? -90 : 90) : 0

                    sourceComponent: tickmarkLabelStyle.tickmark

                    readonly property int __index: index
                    property QtObject styleData: QtObject {
                        property alias index: tickmarkDelegateLoader.__index
                    }
                }
            }

            Repeater {
                id: minorTickmarkRepeater
                model: privateScope.tickmarkCount * control.minorTickmarkCount
                delegate: Loader {
                    id: minorTickmarkDelegateLoader

                    x: {
                        if (control.orientation === Qt.Vertical) {
                            if (control.alignment === Qt.AlignRight) {
                                return effectiveBounds.width - width;
                            }
                            // Either it's invalid or Qt.AlignLeft (which is the
                            // default when an invalid alignment is specified).
                            return 0;
                        }
                        // Horizontal.
                        // We rotate the tickmark around the top left, so in order to have it
                        // centered over the edge of the container, we need to push it to the side after rotating it.
                        var rotationAjustment = control.alignment === Qt.AlignTop ? height / 2 : -height / 2;
                        var offset = (Math.floor(index / control.minorTickmarkCount) + 1) * privateScope.minorTickmarkDistance;
                        return index * privateScope.minorTickmarkDistance + offset + rotationAjustment;
                    }

                    y: {
                        if (control.orientation === Qt.Horizontal) {
                            if (control.alignment === Qt.AlignBottom) {
                                // We rotate the tickmark -90 degrees in this scenario,
                                // so it swings back around and anchored itself to the edge for us.
                                return effectiveBounds.height;
                            }
                            // Either it's invalid or Qt.AlignTop (which is the
                            // default when an invalid alignment is specified).
                            return 0;
                        }
                        // Vertical.
                        // Every minorTickmarkCount steps, we want to offset the tickmarks by one.
                        var offset = (Math.floor(index / control.minorTickmarkCount) + 1) * privateScope.minorTickmarkDistance;
                        return effectiveBounds.height - index * privateScope.minorTickmarkDistance - height / 2 - offset;
                    }

                    width: privateScope.minorTickmarkLength
                    height: privateScope.minorTickmarkWidth

                    transformOrigin: Qt.TopLeftCorner
                    rotation: control.orientation === Qt.Horizontal ? (control.alignment === Qt.AlignBottom ? -90 : 90) : 0

                    sourceComponent: tickmarkLabelStyle.minorTickmark

                    readonly property int __index: index
                    property QtObject styleData: QtObject {
                        property alias index: minorTickmarkDelegateLoader.__index
                    }
                }
            }

            Repeater {
                id: tickmarkTextRepeater
                model: privateScope.tickmarkCount + 1
                delegate: Loader {
                    id: tickmarkTextRepeaterDelegate
                    sourceComponent: tickmarkLabel
                    x: {
                        var xPos = 0;
                        if (control.orientation === Qt.Vertical) {
                            xPos = control.alignment === Qt.AlignRight
                                ? effectiveBounds.width - privateScope.tickmarkLength - width - privateScope.tickmarkTextMargin
                                : privateScope.tickmarkLength + privateScope.tickmarkTextMargin;
                        } else {
                            xPos = styleData.index * privateScope.tickmarkDistance - width / 2;
                        }
                        xPos;
                    }
                    y: {
                        var yPos = 0;
                        if (control.orientation === Qt.Vertical) {
                            yPos = effectiveBounds.height - styleData.index * privateScope.tickmarkDistance - height / 2;
                        } else {
                            yPos = control.alignment === Qt.AlignBottom
                                ? effectiveBounds.height - privateScope.tickmarkLength - height - privateScope.tickmarkTextMargin
                                : privateScope.tickmarkLength + privateScope.tickmarkTextMargin;
                        }
                        yPos;
                    }

                    readonly property int __index: index
                    property QtObject styleData: QtObject {
                        property alias index: tickmarkTextRepeaterDelegate.__index
                        property int value: privateScope.markerTextFromPos(index / (tickmarkTextRepeater.count - 1))
                    }
                }
            }
        }
    }
}
