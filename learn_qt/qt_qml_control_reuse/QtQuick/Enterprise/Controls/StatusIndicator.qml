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
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls 1.1
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype StatusIndicator
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.1
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-non-interactive
    \brief An indicator that displays on or off states.

    \image statusindicator-off.png A StatusIndicator in the off state
    A StatusIndicator in the off state.
    \image statusindicator-on.png A StatusIndicator in the on state
    A StatusIndicator in the on state.

    The StatusIndicator displays on or off states. By using different
    colors via the \l color property, StatusIndicator can provide extra
    context to these states. For example:

    \table
    \row
        \li QML
        \li Result
    \row
        \li
            \code
                import QtQuick 2.2
                import QtQuick.Enterprise.Controls 1.1

                Rectangle {
                    width: 100
                    height: 100
                    color: "#cccccc"

                    StatusIndicator {
                        anchors.centerIn: parent
                        color: "green"
                    }
                }
            \endcode
        \li \image statusindicator-green.png "Green StatusIndicator"
    \endtable

    You can create a custom appearance for a StatusIndicator by assigning a
    \l StatusIndicatorStyle.
*/

Control {
    id: statusIndicator

    style: StatusIndicatorStyle {}

    /*!
        This property specifies whether the indicator is on or off.

        The default value is \c false (off).
    */
    property bool on: false

    /*!
        This property specifies the color of the indicator when it is on.

        The default value is \c "red".
    */
    property color color: "red"
}
