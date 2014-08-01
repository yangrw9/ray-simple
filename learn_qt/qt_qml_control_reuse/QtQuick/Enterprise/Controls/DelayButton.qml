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
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype DelayButton
    \inherits QtQuickControls::Button
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.0
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-interactive
    \brief A checkable button that triggers an action when held in long enough.

    \image delaybutton.png A DelayButton

    The DelayButton is a checkable button that incorporates a delay before
    the button becomes checked and the \l activated signal is emitted. This
    delay prevents accidental presses.

    The current progress is expressed as a decimal value between \c 0.0 and
    \c 1.0. The time it takes for \l activated to be emitted is measured in
    milliseconds, and can be set with the \l delay property.

    The progress is indicated by a progress indicator around the button. When
    the indicator reaches completion, it flashes.

    \image delaybutton-progress.png A DelayButton being held down
    A DelayButton being held down
    \image delaybutton-activated.png A DelayButton after being activated
    A DelayButton after being activated

    You can create a custom appearance for a DelayButton by assigning a
    \l DelayButtonStyle.
*/

Button {
    id: root

    style: DelayButtonStyle {}

    /*!
        \qmlproperty real DelayButton::progress

        This property holds the current progress as displayed by the progress
        indicator, in the range \c 0.0 - \c 1.0.
    */
    readonly property alias progress: privateScope.progress

    /*!
        This property holds the time it takes (in milliseconds) for \l progress
        to reach \c 1.0 and emit \l activated.

        The default value is \c 3000 ms.
    */
    property int delay: 3000

    /*!
        This signal is emitted when \l progress reaches \c 1.0 and the button
        becomes checked.
    */
    signal activated

    QtObject {
        id: privateScope

        /*! \internal */
        property real progress: 0.0

        /*! \internal */
        readonly property bool progressingForward: pressed && progress < 1

        Behavior on progress {
            NumberAnimation {
                duration: Math.max(0, (privateScope.progressingForward ? progress : 1 - progress) * delay)
            }
        }
    }

    Binding {
        // Force checkable to false to get full control over the checked -property
        target: root
        property: "checkable"
        value: false
    }

    onProgressChanged: {
        if (progress == 1.0) {
            checked = true;
            activated();
        }
    }

    onPressedChanged: {
        if (checked) {
            if (pressed) {
                // Pressed the button to stop the activation.
                privateScope.progress = 0;
                checked = false;
            }
        } else {
            // Not active. Either the button is being held down or let go.
            privateScope.progress = pressed ? 1 : 0;
        }
    }
}
