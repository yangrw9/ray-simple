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
import QtQuick.Controls.Styles 1.0
import QtQuick.Enterprise.Controls.Styles 1.1
import QtQuick.Enterprise.Controls.Private.CppUtils 1.1

/*!
    \qmltype DelayButtonStyle
    \inqmlmodule QtQuick.Enterprise.Controls.Styles
    \since QtQuick.Enterprise.Controls.Styles 1.0
    \ingroup enterprisecontrolsstyling
    \brief Provides custom styling for DelayButton.

    You can create a custom DelayButton by replacing the following delegates:
    \list
        \li \l foreground
        \li \l {QtQuick.Controls.Styles::ButtonStyle::label}{label}
    \endlist
*/

CircularButtonStyle {
    id: delayButtonStyle

    /*!
        The gradient of the progress bar around the button.
    */
    property Gradient progressBarGradient: Gradient {
        GradientStop {
            position: 0
            color: "#ff6666"
        }
        GradientStop {
            position: 1
            color: "#ff0000"
        }
    }

    /*!
        The color of the drop shadow under the progress bar.
    */
    property color progressBarDropShadowColor: "#ff6666"

    background: Item {
        Canvas {
            id: backgroundCanvas
            anchors.fill: parent

            Connections {
                target: control
                onPressedChanged: backgroundCanvas.requestPaint()
                onCheckedChanged: backgroundCanvas.requestPaint()
            }

            onPaint: {
                var ctx = getContext("2d");
                __buttonHelper.paintBackground(ctx);
            }
        }
    }

    /*!
        The foreground of the button.

        The progress bar is drawn here.
    */
    property Component foreground: Item {
        id: foregroundItem

        state: "normal"
        states: [
            State {
                name: "normal"

                PropertyChanges {
                    target: foregroundItem
                    opacity: 1
                }
            },
            State {
                name: "activated"
            }
        ]

        transitions: [
            Transition {
                from: "normal"
                to: "activated"
                SequentialAnimation {
                    loops: Animation.Infinite

                    NumberAnimation {
                        target: foregroundItem
                        property: "opacity"
                        from: 0.8
                        to: 0
                        duration: 500
                        easing.type: Easing.InOutSine
                    }
                    NumberAnimation {
                        target: foregroundItem
                        property: "opacity"
                        from: 0
                        to: 0.8
                        duration: 500
                        easing.type: Easing.InOutSine
                    }
                }
            }
        ]

        Connections {
            target: control
            onActivated: state = "activated"
            onCheckedChanged: if (!control.checked) state = "normal"
        }

        CircularProgressBar {
            id: progressBar
            visible: false
            width: Math.min(parent.width, parent.height) + progressBarDropShadow.radius * 3 * 2
            height: width
            anchors.centerIn: parent
            antialiasing: true
            barWidth: __buttonHelper.outerArcLineWidth
            inset: progressBarDropShadow.radius * 3

            progress: control.progress

            // TODO: Add gradient property if/when we drop support for building with 5.1.
            function updateGradient() {
                clearStops();
                for (var i = 0; i < progressBarGradient.stops.length; ++i) {
                    addStop(progressBarGradient.stops[i].position, progressBarGradient.stops[i].color);
                }
            }

            Component.onCompleted: updateGradient()

            Connections {
                target: delayButtonStyle
                onProgressBarGradientChanged: progressBar.updateGradient()
            }
        }

        DropShadow {
            id: progressBarDropShadow
            anchors.fill: progressBar
            fast: true
            // QTBUG-33747
//            cached: !control.pressed
            radius: 4
            samples: radius * 2
            color: progressBarDropShadowColor
            source: progressBar
        }
    }

    panel: Item {
        implicitWidth: Math.max(labelLoader.implicitWidth + padding.left + padding.right, __buttonHelper.implicitWidth)
        implicitHeight: Math.max(labelLoader.implicitHeight + padding.top + padding.bottom, __buttonHelper.implicitHeight)

        Loader {
            id: backgroundLoader
            anchors.fill: parent
            sourceComponent: background
        }

        Loader {
            id: foregroundLoader
            anchors.fill: parent
            sourceComponent: foreground
        }

        Loader {
            id: labelLoader
            sourceComponent: label
            anchors.fill: parent
            anchors.leftMargin: padding.left
            anchors.topMargin: padding.top
            anchors.rightMargin: padding.right
            anchors.bottomMargin: padding.bottom
        }
    }
}
