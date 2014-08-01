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
    \qmltype ToggleButton
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.0
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-interactive
    \brief A push button that toggles between two states.

    \image togglebutton-unchecked.png An unchecked ToggleButton
    An unchecked ToggleButton.
    \image togglebutton-checked.png A checked ToggleButton
    A checked ToggleButton.

    The ToggleButton is a simple extension of Qt Quick Controls' Button, using
    the checked property to toggle between two states: \e checked and
    \e unchecked. It enhances the visibility of a checkable button's state by
    placing color-coded indicators around the button.

    You can create a custom appearance for a ToggleButton by assigning a
    \l ToggleButtonStyle.
*/

Button {
    checkable: true
    style: ToggleButtonStyle {}
}
