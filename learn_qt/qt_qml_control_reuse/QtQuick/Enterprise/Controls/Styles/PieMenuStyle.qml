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
import QtQuick.Controls 1.0
import QtQuick.Controls.Private 1.0
import QtQuick.Enterprise.Controls 1.1
import QtQuick.Enterprise.Controls.Styles 1.1
import QtQuick.Enterprise.Controls.Private 1.0

/*!
    \qmltype PieMenuStyle
    \inqmlmodule QtQuick.Enterprise.Controls.Styles
    \since QtQuick.Enterprise.Controls.Styles 1.0
    \ingroup enterprisecontrolsstyling
    \brief Provides custom styling for PieMenu.

    PieMenuStyle is a style for PieMenu that draws each section of the menu as a
    filled "slice".

    You can create a custom pie menu by replacing the following delegates:
    \list
        \li \l background
        \li \l cancel
        \li \l menuItem
        \li \l title
    \endlist

    To customize the appearance of each menuItem without having to define your
    own, you can use the \l backgroundColor and \l selectionColor properties.
    To customize the drop shadow, use the \l shadowColor, \l shadowRadius and
    \l shadowSpread properties.

    Icons that are too large for the section that they are in will be scaled
    down appropriately.

    To style individual sections of the menu, use the menuItem component:
    \code
    PieMenuStyle {
        shadowRadius: 0

        menuItem: Item {
            id: item
            rotation: -90 + sectionCenterAngle(styleData.index)

            Rectangle {
                width: parent.height * 0.2
                height: width
                color: "darkorange"
                radius: width / 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: textItem
                    text: control.menuItems[styleData.index].text
                    anchors.centerIn: parent
                    color: control.currentIndex === styleData.index ? "red" : "white"
                    rotation: -item.rotation
                }
            }
        }
    }
    \endcode

    \image piemenu-menuitem-example.png A custom PieMenu
*/

Style {
    id: pieMenuStyle


    /*! The background color. */
    property color backgroundColor: Qt.rgba(0.6, 0.6, 0.6, 0.66)

    /*! The selection color. */
    property color selectionColor: "#eee"

    /*! The shadow color. */
    property color shadowColor: Qt.rgba(0, 0, 0, 0.26)

    /*! The shadow radius. */
    property real shadowRadius: 50

    /*! The shadow spread. */
    property real shadowSpread: 0.3

    /*!
        The distance from the center of the menu to the outer edge of the menu.

        \sa cancelRadius
    */
    readonly property real radius: Math.min(control.width, control.height) * 0.5

    /*!
        The radius of the area that is used to cancel the menu.

        \sa radius
    */
    property real cancelRadius: radius * 0.4

    /*!
        The positive angle (in degrees) that defines the beginning of the range
        within which menu items are displayed. The angle must be within the
        range of \c 0 to \c 360 degrees, inclusive. Menu items are displayed
        clockwise.

        \sa endAngle
    */
    property real startAngle: 270

    /*!
        The positive angle (in degrees) that defines the end of the range within
        which menu items are displayed. The angle must be within the range of
        \c 0 to \c 360 degrees, inclusive. Menu items are displayed clockwise.

        \sa startAngle
    */
    property real endAngle: 90

    /*!
        Returns the start of the section at \a itemIndex as an angle in degrees.
    */
    function sectionStartAngle(itemIndex) {
        return Utils.radToDeg(control.__protectedScope.sectionStartAngle(itemIndex));
    }

    /*!
        Returns the center of the section at \a itemIndex as an angle in
        degrees.
    */
    function sectionCenterAngle(itemIndex) {
        return Utils.radToDeg(control.__protectedScope.sectionCenterAngle(itemIndex));
    }

    /*!
        Returns the end of the section at \a itemIndex as an angle in degrees.
    */
    function sectionEndAngle(itemIndex) {
        return Utils.radToDeg(control.__protectedScope.sectionEndAngle(itemIndex));
    }

    /*! \internal */
    property QtObject __protectedScope: QtObject {
        /*!
            \internal

            Converts a value expressed as a percentage of \l radius to
            a pixel value.
        */
        function toPixels(percentageOfRadius) {
            return percentageOfRadius * radius;
        }

        /*!
            The distance in pixels from the center of each menu item's icon to the
            center of the menu. A higher value means that the icons will be further
            from the center of the menu.
        */
        readonly property real iconOffset: cancelRadius + ((radius - cancelRadius) / 2)

        property real angleOffset: Utils.degToRad(-90)

        readonly property real selectableRadius: radius - cancelRadius
    }

    /*!
        The background of the menu.

        By default, there is no background defined.
    */
    property Component background

    /*!
        The cancel component of the menu.

        This is an area in the center of the menu that closes the menu when
        clicked.

        By default, it is not visible.
    */
    property Component cancel: null

    /*!
        \since 1.1

        The component that displays the text of the currently selected menu
        item, or the title if there is no current item.

        The current item's text is available via the \c styleData.text
        property.
    */
    property Component title: Text {
        font.pointSize: 20
        text: styleData.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "#ccc"
        antialiasing: true
    }

    /*!
        This component defines each section of the pie menu.

        This component covers the width and height of the control.

        No mouse events are propagated to this component, which means that
        controls like Button will not function when used within it. You can
        check if the mouse is over this section by comparing
        \c control.currentIndex to \c styleData.index.
    */
    property Component menuItem: Item {
        id: actionRootDelegateItem

        function drawRingSection(ctx, x, y, section, r, ringWidth, ringColor) {
            ctx.fillStyle = ringColor;

            // Draw one section.
            ctx.beginPath();
            ctx.moveTo(x,y);

            // Canvas draws 0 degrees at 3 o'clock, whereas we want it to draw it at 12.
            ctx.arc(x, y, r, control.__protectedScope.sectionStartAngle(section) + __protectedScope.angleOffset,
                control.__protectedScope.sectionEndAngle(section) + __protectedScope.angleOffset, false);
            ctx.fill();

            // Either change this to the background color, or use the global composition.
            ctx.fillStyle = "black";
            ctx.globalCompositeOperation = "destination-out";
            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.arc(x, y, ringWidth, 0, Math.PI * 2);
            ctx.closePath();
            ctx.fill();

            // If using the global composition method, make sure to change it back to default.
            ctx.globalCompositeOperation = "source-over";
        }

        Canvas {
            id: actionCanvas
            anchors.fill: parent
            property color currentColor: control.currentIndex === styleData.index ? selectionColor : backgroundColor

            Connections {
                target: pieMenuStyle
                onStartAngleChanged: actionCanvas.requestPaint()
                onEndAngleChanged: actionCanvas.requestPaint()
            }

            Connections {
                target: control
                onCurrentIndexChanged: actionCanvas.requestPaint()
            }

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                drawRingSection(ctx, width / 2, height / 2, styleData.index, radius, cancelRadius, currentColor);
            }
        }
        Loader {
            active: iconSource != ""

            readonly property string iconSource: styleData.index < control.__protectedScope.visibleItems.length
                ? control.__protectedScope.visibleItems[styleData.index].iconSource
                : ""

            sourceComponent: Image {
                id: iconImage
                source: iconSource
                x: pos.x
                y: pos.y
                scale: scaleFactor

                readonly property point pos: Utils.centerAlongCircle(
                    actionRootDelegateItem.width / 2, actionRootDelegateItem.height / 2, width, height,
                    Utils.degToRad(sectionCenterAngle(styleData.index)) + __protectedScope.angleOffset, __protectedScope.iconOffset)

                /*
                    The icons should scale with the menu at some point, so that they
                    stay within the bounds of each section. We down-scale the image by
                    whichever of the following amounts are larger:

                    a) The amount by which the largest dimension's diagonal size exceeds
                    the "selectable" radius. The selectable radius is the distance in pixels
                    between lines A and B in the incredibly visually appealing image below:

                           __________
                         -      B     -
                       /                \
                     /        ____        \
                    |        /  A \        |
                    --------|      |--------

                    b) The amount by which the diagonal exceeds the circumference of
                    one section.
                */
                readonly property real scaleFactor: {
                    var largestDimension = Math.max(iconImage.sourceSize.width, iconImage.sourceSize.height) * Math.sqrt(2);
                    // TODO: add padding
                    var radiusDifference = largestDimension - __protectedScope.selectableRadius;
                    var circumferenceDifference = largestDimension - control.__protectedScope.circumferenceOfSection;
                    if (circumferenceDifference > 0 || radiusDifference > 0) {
                        // We need to down-scale.
                        if (radiusDifference > circumferenceDifference) {
                            return __protectedScope.selectableRadius / largestDimension;
                        } else {
                            return control.__protectedScope.circumferenceOfSection / largestDimension;
                        }
                    }
                    return 1;
                }
            }
        }
    }

    /*! \internal */
    property Component panel: Item {
        implicitWidth: 200
        implicitHeight: 200

        property alias titleItem: titleLoader.item

        Item {
            id: itemgroup
            anchors.fill: parent

            Loader {
                id: backgroundLoader
                sourceComponent: background
                anchors.fill: parent
            }

            Loader {
                id: cancelLoader
                sourceComponent: cancel
                anchors.centerIn: parent
            }

            Repeater {
                id: menuItemRepeater
                model: control.__protectedScope.visibleItems

                delegate: Loader {
                    id: menuItemLoader
                    anchors.fill: parent
                    sourceComponent: menuItem

                    readonly property int __index: index
                    property QtObject styleData: QtObject {
                        property alias index: menuItemLoader.__index
                    }
                }
            }
        }
        DropShadow {
            id: dropShadow
            anchors.fill: itemgroup
            fast: true
            radius: shadowRadius
            spread: shadowSpread
            transparentBorder: true
            samples: 12
            color: shadowColor
            source: itemgroup
        }

        Loader {
            id: titleLoader
            sourceComponent: title
            x: parent.x + parent.width / 2 - width / 2
            y: -height - 10

            property QtObject styleData: QtObject {
                property string text: control.currentIndex !== -1
                    ? control.__protectedScope.visibleItems[control.currentIndex].text
                    : control.title
            }
        }
    }
}
