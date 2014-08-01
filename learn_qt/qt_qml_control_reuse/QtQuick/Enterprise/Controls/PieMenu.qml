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
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls 1.1
import QtQuick.Enterprise.Controls.Private 1.0
import QtQuick.Enterprise.Controls.Private.CppUtils 1.0 as CppUtils
import QtQuick.Enterprise.Controls.Styles 1.1

/*!
    \qmltype PieMenu
    \inqmlmodule QtQuick.Enterprise.Controls
    \since QtQuick.Enterprise.Controls 1.0
    \ingroup enterprisecontrols
    \ingroup enterprisecontrols-interactive
    \brief A popup menu that displays several menu items along an arc.

    \image piemenu.png A PieMenu

    The PieMenu provides a radial context menu as an alternative to a
    traditional menu. All of the items in a PieMenu are an equal distance
    from the center of the control.

    \section2 Populating the Menu

    To create a menu, define at least one MenuItem as a child of it:
    \code
    PieMenu {
        id: pieMenu

        MenuItem {
            text: "Action 1"
            onTriggered: print("Action 1")
        }
        MenuItem {
            text: "Action 2"
            onTriggered: print("Action 2")
        }
        MenuItem {
            text: "Action 3"
            onTriggered: print("Action 3")
        }
    }
    \endcode

    By default, only the currently selected item's text is displayed above the
    menu. To provide text that is always visible when there is no current item,
    set the \l title property.

    \section2 Displaying the Menu

    The typical use case for a menu is to open at the point of the mouse
    cursor after a right click occurs. To do that, define a MouseArea that
    covers the region upon which clicks should open the menu. When the
    MouseArea is right-clicked, call the popup() function:
    \code
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton

        onClicked: pieMenu.popup(mouseX, mouseY)
    }
    \endcode

    When the menu is shown, it is reparented to the window, and sets a large
    \l z value to ensure it is above all other items.

    PieMenu can be displayed at any position on the screen. With a traditional
    context menu, the menu would be positioned with its top left corner at the
    position of the right click, but since PieMenu is radial, we position it
    centered over the position of the right click.

    To create a PieMenu that opens after a long press and selects items upon
    releasing, you can combine ActivationMode.ActivateOnRelease with a MouseArea
    using a Timer:
    \code
    MouseArea {
        id: touchArea
        anchors.fill: parent

        Timer {
            id: pressAndHoldTimer
            interval: 300
            onTriggered: pieMenu.popup(touchArea.mouseX, touchArea.mouseY);
        }

        onPressed: pressAndHoldTimer.start()
        onReleased: pressAndHoldTimer.stop();
    }

    PieMenu {
        id: pieMenu

        activationMode: ActivationMode.ActivateOnRelease

        MenuItem {
            text: "Action 1"
            onTriggered: print("Action 1")
        }
        MenuItem {
            text: "Action 2"
            onTriggered: print("Action 2")
        }
        MenuItem {
            text: "Action 3"
            onTriggered: print("Action 3")
        }
    }
    \endcode

    You can hide individual menu items by setting their visible property to
    \c false. Hiding items does not affect the
    \l {PieMenuStyle::startAngle}{startAngle} or
    \l {PieMenuStyle::endAngle}{endAngle}; the remaining items will grow to
    consume the available space.

    You can create a custom appearance for a PieMenu by assigning a
    \l PieMenuStyle.
*/

Control {
    id: pieMenu
    visible: false
    z: 1000000

    style: PieMenuStyle {}

    /*!
        This property reflects the angle (in degrees) created by the imaginary
        line from the center of the menu to the position of the cursor.

        Its value is undefined when the menu is not visible.
    */
    readonly property real selectionAngle: {
        var centerX = width / 2;
        var centerY = height / 2;
        var targetX = __protectedScope.selectionPos.x;
        var targetY = __protectedScope.selectionPos.y;

        var xDistance = centerX - targetX;
        var yDistance = centerY - targetY;

        var angleToTarget = Math.atan2(xDistance, yDistance) * -1;
        if (angleToTarget < 0) {
            angleToTarget += Utils.degToRad(360);
        }
        angleToTarget;
    }

    /*!
        \qmlproperty enumeration PieMenu::activationMode

        This property determines the method for selecting items in the menu.

        \list
        \li An activationMode of \a PieMenu.ActivateOnPress means that menu
        items will only be selected when a mouse press event occurs over them.

        \li An activationMode of \a PieMenu.ActivateOnRelease means that menu
        items will only be selected when a mouse release event occurs over them.
        This means that the user must keep the mouse button down after opening
        the menu and release the mouse over the item they wish to select.

        \li An activationMode of \a PieMenu.ActivateOnClick means that menu
        items will only be selected when the user clicks once over them.
        \endlist

        \warning Changing the activationMode while the menu is visible will
        result in undefined behavior.
    */
    property int activationMode: ActivationMode.ActivateOnClick

    /*!
        \qmlproperty list<MenuItem> menuItems

        The list of menu items displayed by this menu.

        You can assign menu items by declaring them as children of PieMenu:
        \code
        PieMenu {
            MenuItem {
                text: "Action 1"
                onTriggered: function() { print("Action 1"); }
            }
            MenuItem {
                text: "Action 2"
                onTriggered: function() { print("Action 1"); }
            }
            MenuItem {
                text: "Action 3"
                onTriggered: function() { print("Action 1"); }
            }
        }
        \endcode
    */
    default property alias menuItems: defaultPropertyHack.menuItems

    QtObject {
        // Can't specify a list as a default property (QTBUG-10822)
        id: defaultPropertyHack
        property list<MenuItem> menuItems
    }

    /*!
        \qmlproperty int PieMenu::currentIndex

        The index of the the menu item that is currently under the mouse,
        or \c -1 if there is no such item.
    */
    readonly property alias currentIndex: protectedScope.currentIndex

    /*!
        \qmlproperty int PieMenu::currentItem

        The menu item that is currently under the mouse, or \c null if there is
        no such item.
    */
    readonly property alias currentItem: protectedScope.currentItem

    /*!
        \since 1.1

        This property defines the text that is shown above the menu when
        there is no current menu item (currentIndex is \c -1).

        The default value is \c "" (an empty string).
    */
    property string title: ""

    /*!
        \qmlmethod void popup(real x, real y)

        Opens the menu at coordinates \a x, \a y.
     */
    function popup(x, y) {
        if (x !== undefined)
            pieMenu.x = x - pieMenu.width / 2;
        if (y !== undefined)
            pieMenu.y = y - pieMenu.height / 2;

        pieMenu.visible = true;
    }

    /*!
        \since QtQuick.Enterprise.Controls 1.1

        \qmlmethod void addItem(string text)

        Adds an item to the end of the menu items.

        Equivalent to passing calling \c insertItem(menuItems.length, text).

        Returns the newly added item.
    */
    function addItem(text) {
        return insertItem(menuItems.length, text);
    }

    /*!
        \since QtQuick.Enterprise.Controls 1.1

        \qmlmethod void insertItem(int before, string text)

        Inserts a MenuItem with \a text before the index at \a before.

        To insert an item at the end, pass \c menuItems.length.

        Returns the newly inserted item, or \c null if \a before is invalid.
    */
    function insertItem(before, text) {
        if (before < 0 || before > menuItems.length) {
            return null;
        }

        var newItems = __protectedScope.copyItemsToJsArray();
        var newItem = Qt.createQmlObject("import QtQuick.Controls 1.0; MenuItem {}", pieMenu, "");
        newItem.text = text;
        newItems.splice(before, 0, newItem);

        menuItems = newItems;
        return newItem;
    }

    /*!
        \since QtQuick.Enterprise.Controls 1.1

        \qmlmethod void removeItem(item)

        Removes \a item from the menu.
    */
    function removeItem(item) {
        for (var i = 0; i < menuItems.length; ++i) {
            if (menuItems[i] === item) {
                var newItems = __protectedScope.copyItemsToJsArray();

                newItems.splice(i, 1);
                menuItems = newItems;
                break;
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: activationMode !== ActivationMode.ActivateOnRelease
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        // The mouse thief also updates the selectionPos, so we can't bind to
        // this mouseArea's mouseX/mouseY.
        onPositionChanged: {
            __protectedScope.selectionPos = Qt.point(mouseX, mouseY)
        }
    }

    CppUtils.MouseThief {
        id: mouseThief

        onPressed: {
            __protectedScope.selectionPos = Qt.point(mouseX, mouseY);
            __protectedScope.handleEvent(ActivationMode.ActivateOnPress);
        }
        onReleased: {
            __protectedScope.selectionPos = Qt.point(mouseX, mouseY);
            __protectedScope.handleEvent(ActivationMode.ActivateOnRelease);
        }
        onClicked: {
            __protectedScope.selectionPos = Qt.point(mouseX, mouseY);
            __protectedScope.handleEvent(ActivationMode.ActivateOnClick);
        }
        onTouchUpdate: __protectedScope.selectionPos = Qt.point(mouseX, mouseY)
    }

    onVisibleChanged: {
        // parent check is for when it's created without a parent,
        // which we do this in the tests, for example.
        if (parent) {
            if (visible) {
                var rootParent = parent;
                while (rootParent.parent) {
                    rootParent = rootParent.parent;
                }
                pieMenu.parent = rootParent;

                __protectedScope.moveWithinBounds(rootParent);

                // We need to grab the mouse so that we can detect released()
                // (which is only emitted after pressed(), which our MouseArea can't
                // emit as it didn't have focus until we were made visible).
                mouseThief.grabMouse(mouseArea);
            } else {
                mouseThief.ungrabMouse();
                __protectedScope.selectionPos = Qt.point(width / 2, height / 2);
            }
        }
    }
    onSelectionAngleChanged: __protectedScope.checkForCurrentItem()

    /*! \internal */
    property QtObject __protectedScope: QtObject {
        id: protectedScope

        property int currentIndex: -1
        property MenuItem currentItem: currentIndex != -1 ? visibleItems[currentIndex] : null
        property point selectionPos: Qt.point(width / 2, height / 2)
        readonly property var localRect: mapFromItem(mouseArea, mouseArea.mouseX, mouseArea.mouseY)
        readonly property var visibleItems: {
            var items = [];
            for (var i = 0; i < menuItems.length; ++i) {
                if (menuItems[i].visible) {
                    items.push(menuItems[i]);
                }
            }
            return items;
        }

        // Can't bind directly, because the menu sets this to (0, 0) on closing.
        onLocalRectChanged: {
            if (visible)
                selectionPos = Qt.point(localRect.x, localRect.y);
        }

        function copyItemsToJsArray() {
            var newItems = [];
            for (var j = 0; j < menuItems.length; ++j) {
                newItems.push(menuItems[j]);
            }
            return newItems;
        }

        /*!
            Returns \c true if the mouse is over the section at \a itemIndex.
        */
        function isMouseOver(itemIndex) {
            if (__style == null)
                return;

            var sectionStart = __protectedScope.sectionStartAngle(itemIndex);
            var sectionEnd = __protectedScope.sectionEndAngle(itemIndex);
            var pastStart = selectionAngle >= sectionStart;
            var isWithinOurAngle = false;
            if (sectionStart > sectionEnd) {
                // This section spans over the Math.PI * 2 ==> 0 wrap-around point,
                // so we have to take that into account.
                if (selectionAngle > sectionStart && selectionAngle < Utils.pi2) {
                    // The selection angle is past our start angle,
                    // but before the wrap point; it's within our section.
                    isWithinOurAngle = true;
                } else if (selectionAngle >= 0 && selectionAngle < sectionEnd) {
                    // The selection angle is at or past the wrap point,
                    // but before our end angle; it's within our section.
                    isWithinOurAngle = true;
                }
            } else {
                // This section doesn't, so it doesn't matter.
                isWithinOurAngle = selectionAngle >= sectionStart && selectionAngle < sectionEnd;
            }

            var x1 = width / 2;
            var y1 = height / 2;
            var x2 = __protectedScope.selectionPos.x;
            var y2 = __protectedScope.selectionPos.y;
            var distanceFromCenter = Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2);
            var cancelRadiusSquared = __style.cancelRadius * __style.cancelRadius;
            var styleRadiusSquared = __style.radius * __style.radius;
            var isWithinOurRadius = distanceFromCenter >= cancelRadiusSquared
                && distanceFromCenter < styleRadiusSquared - cancelRadiusSquared;
            return isWithinOurAngle && isWithinOurRadius;
        }

        readonly property real arcRange: Math.abs(endAngleRadians - startAngleRadians)

        /*!
            The size of one section in radians.
        */
        readonly property real sectionSize: {
            (arcRange < 0 ? Utils.pi2 - arcRange : arcRange) / visibleItems.length;
        }
        readonly property real startAngleRadians: Utils.degToRad(__style.startAngle)
        readonly property real endAngleRadians: Utils.degToRad(__style.endAngle)

        readonly property real circumferenceOfFullRange: 2 * Math.PI * __style.radius
        readonly property real percentageOfFullRange: (arcRange / (Math.PI * 2))
        readonly property real circumferenceOfSection: (sectionSize / arcRange) * (percentageOfFullRange * circumferenceOfFullRange)

        function sectionStartAngle(section) {
            var start = startAngleRadians + section * sectionSize;
            return start >= Utils.pi2 ? start - Utils.pi2 : start;
        }

        function sectionCenterAngle(section) {
            var ssa = sectionStartAngle(section);
            var sea = sectionEndAngle(section);
            // Account for 0 - 360 wrap point, which happens when the start
            // angle is greater than the end angle. For example (in degrees):
            // When the start angle is 350 and the end angle is 50, the center
            // angle will be 20 ((350 + 50) - 360) / 2).
            return ssa < sea ? (ssa + (sea - sectionStartAngle(section)) / 2)
                : ((ssa + sea) - Utils.pi2) / 2;
        }

        function sectionEndAngle(section) {
            var end = startAngleRadians + section * sectionSize + sectionSize;
            return end > Utils.pi2 ? end - Utils.pi2 : end;
        }

        function handleEvent(mode) {
            if (visible && activationMode === mode) {
                checkForCurrentItem();
                if (currentItem) {
                    currentItem.trigger();
                }
                // If the cursor was over an item; activate it.
                // If it wasn't, close our menu regardless.
                visible = false;
                // The menu is closed now, so the currentIndex can't be valid.
                currentIndex = -1;
            }
        }

        function checkForCurrentItem() {
            // Use a temporary varibable because setting currentIndex to -1 here
            // will trigger onCurrentIndexChanged.
            var hoveredIndex = -1;
            for (var i = 0; i < visibleItems.length; ++i) {
                if (isMouseOver(i)) {
                    hoveredIndex = i;
                    break;
                }
            }
            currentIndex = hoveredIndex;
        }

        function isWithinBottomEdge() {
            return pieMenu.__style.startAngle >= 270 && pieMenu.__style.endAngle <= 90
                && ((pieMenu.__style.startAngle < 360 && pieMenu.__style.endAngle <= 360)
                    || (pieMenu.__style.startAngle >= 0 && pieMenu.__style.endAngle > 0));
        }

        function isWithinTopEdge() {
            return pieMenu.__style.startAngle >= 90 && pieMenu.__style.startAngle < 270
                && pieMenu.__style.endAngle > 90 && pieMenu.__style.endAngle <= 270;
        }

        function isWithinLeftEdge() {
            return (pieMenu.__style.startAngle === 360 || pieMenu.__style.startAngle >= 0) && pieMenu.__style.startAngle < 180
                && pieMenu.__style.endAngle > 0 && pieMenu.__style.endAngle <= 180;
        }

        function isWithinRightEdge() {
            return pieMenu.__style.startAngle >= 180 && pieMenu.__style.startAngle < 360
                && pieMenu.__style.endAngle > 180 && (pieMenu.__style.endAngle === 360 || pieMenu.__style.endAngle === 0);
        }

        /*!
            Moves the menu if it would open with parts outside of \a rootParent.
        */
        function moveWithinBounds(rootParent) {
            if (pieMenu.x < rootParent.x && !isWithinLeftEdge()) {
                // The width and height of the menu is always that of a full circle,
                // so the menu is not always outside an edge when it's outside the edge -
                // it depends on the start and end angles.
                pieMenu.x = rootParent.x;
            } else if (pieMenu.x + pieMenu.width > rootParent.width && !isWithinRightEdge()) {
                pieMenu.x = rootParent.x + rootParent.width - pieMenu.width;
            }

            if (pieMenu.y < rootParent.y && !isWithinTopEdge()) {
                pieMenu.y = rootParent.y;
            } else if (pieMenu.y + pieMenu.height > rootParent.height && !isWithinBottomEdge()) {
                pieMenu.y = rootParent.y + rootParent.height - pieMenu.height;
            }
        }
    }
}
