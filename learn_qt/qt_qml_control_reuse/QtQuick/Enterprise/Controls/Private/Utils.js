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

.pragma library

// 360 degrees.
var pi2 = 2 * Math.PI;
// 90 degrees.
var halfPi = Math.PI / 2;

function degToRad(degrees) {
    return degrees * (Math.PI / 180);
}

function radToDeg(radians) {
    return radians * (180 / Math.PI);
}

/*!
    Returns an angle in radians that reflects the position of \a index as a
    section along an arc of \a count sections.

    \a index is an integer less than \a count.
    \a arcStartAngle is the angle in radians at which the arc begins.
    \a arcRange is the circumference of the arc in radians.
*/
function indexToAngle(index, count, arcStartAngle, arcRange) {
    return index * ((arcRange) / count) + arcStartAngle;
}

/*!
    Returns an angle in radians that reflects the position of \a value as a
    percentage of \a maxValue, where the angle returned starts from \a zeroAngle
    and ends at \a zeroAngle + \c Math.PI * 2.

    \a value is any numerical value less than or equal to \a maxValue.
    \a zeroAngle is the angle in radians at which the angle's zero origin should
    begin.
*/
function valueToAngle(value, maxValue, zeroAngle) {
    return ((value / maxValue) * pi2) + zeroAngle;
}

function valueToAngle2(value, minValue, maxValue, zeroAngle) {
    return (value - minValue) / (maxValue - minValue) * pi2 + zeroAngle;
}

function angleToValue(angle, maxValue, zeroAngle) {
    angle -= zeroAngle;
    while (angle < 0)
        angle += pi2;
    return angle * maxValue / pi2;
}

function angleToValue2(angle, minValue, maxValue, zeroAngle) {
    angle -= zeroAngle;
    while (angle < 0)
        angle += pi2;
    return (angle + minValue) * (maxValue - minValue) / pi2;
}

/*!
    Returns the top left position of the item if it were centered along
    a circle according to \a angleOnCircle and \a distanceAlongRadius.

    \a angleOnCircle is from 0.0 - pi2.
    \a distanceAlongRadius is the distance along the radius in pixels.
*/
function centerAlongCircle(xCenter, yCenter, width, height, angleOnCircle, distanceAlongRadius) {
    return Qt.point(
        (xCenter - width / 2) + (distanceAlongRadius * Math.cos(angleOnCircle)),
        (yCenter - height / 2) + (distanceAlongRadius * Math.sin(angleOnCircle)));
}
