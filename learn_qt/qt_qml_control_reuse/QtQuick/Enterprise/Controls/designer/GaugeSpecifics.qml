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

import QtQuick 2.1
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("Gauge")

        SectionLayout {

            Label {
                text: qsTr("Value")
                toolTip: qsTr("Value")
            }
            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.value
                    minimumValue: backendValues.minimumValue.value
                    maximumValue: backendValues.maximumValue.value
                    stepSize: 0.01
                    decimals: 2
                }
                ExpandingSpacer {
                }
            }

            Label {
                text: qsTr("Minimum Value")
                toolTip: qsTr("Minimum Value")
            }
            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.minimumValue
                    minimumValue: 0
                    maximumValue: backendValues.maximumValue.value
                    stepSize: 0.01
                    decimals: 2
                }
                ExpandingSpacer {
                }
            }

            Label {
                text: qsTr("Maximum Value")
                toolTip: qsTr("Maximum Value")
            }
            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maximumValue
                    minimumValue: backendValues.minimumValue.value
                    maximumValue: 1000
                    stepSize: 0.01
                    decimals: 2
                }
                ExpandingSpacer {
                }
            }

//            Label {
//                text: qsTr("Orientation")
//                toolTip: qsTr("Orientation")
//            }
//            SecondColumnLayout {
//                ComboBox {
//                    id: orientationComboBox
//                    backendValue: backendValues.orientation
//                    implicitWidth: 180
//                    model:  ["Vertical", "Horizontal"]
//                }
//                ExpandingSpacer {
//                }
//            }

//            Label {
//                text: qsTr("Tickmark Alignment")
//                toolTip: qsTr("Tickmark Alignment")
//            }

//            SecondColumnLayout {
//                ComboBox {
//                    backendValue: backendValues.orientation
//                    implicitWidth: 180
//                    model: orientationComboBox.currentText === "Vertical" ? ["AlignLeft", "AlignRight"] : ["AlignTop", "AlignBottom"]
//                }
//                ExpandingSpacer {
//                }
//            }
        }
    }
}
