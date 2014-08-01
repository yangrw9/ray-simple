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
import QtQuick.Controls 1.1 as Controls
import QtQuick.Controls.Styles 1.1

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("PieMenu")

        SectionLayout {
            Label {
                text: qsTr("Activation Mode")
                toolTip: qsTr("Activation Mode")
            }
            SecondColumnLayout {
                // Work around ComboBox string => int problem.
                Controls.ComboBox {
                    id: comboBox

                    property variant backendValue: backendValues.activationMode

                    property color textColor: "white"
                    implicitWidth: 180
                    model:  ["ActivateOnPress", "ActivateOnRelease", "ActivateOnClick"]

                    QtObject {
                        property variant valueFromBackend: comboBox.backendValue
                        onValueFromBackendChanged: {
                            comboBox.currentIndex = comboBox.find(comboBox.backendValue.valueToString);
                        }
                    }

                    onCurrentTextChanged: {
                        if (backendValue === undefined)
                            return;

                        if (backendValue.value !== currentText)
                            backendValue.value = comboBox.currentIndex
                    }

                    style: CustomComboBoxStyle {
                        textColor: comboBox.textColor
                    }

                    ExtendedFunctionButton {
                        x: 2
                        y: 4
                        backendValue: comboBox.backendValue
                        visible: comboBox.enabled
                    }
                }
                ExpandingSpacer {
                }
            }
        }
    }
}

