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

QtObject {
    id: circularButtonStyleHelper

    property Item control

    property color buttonColorUpTop: "#e3e3e3"
    property color buttonColorUpBottom: "#b3b3b3"
    property color buttonColorDownTop: "#d3d3d3"
    property color buttonColorDownBottom: "#939393"
    property color outerArcColorTop: "#9c9c9c"
    property color outerArcColorBottom: Qt.rgba(0.941, 0.941, 0.941, 0.29)
    property color innerArcColorTop: "#e3e3e3"
    property color innerArcColorBottom: "#acacac"
    property real innerArcColorBottomStop: 0.4
    property color shineColor: Qt.rgba(1, 1, 1, 0.29)
    property real smallestAxis: Math.min(control.width, control.height)
    property real outerArcLineWidth: smallestAxis * 0.04
    property real innerArcLineWidth: Math.max(1, outerArcLineWidth * 0.1)
    property real shineArcLineWidth: Math.max(1, outerArcLineWidth * 0.1)
    property real implicitWidth: 125
    property real implicitHeight: 125

    property color textColorUp: "#4e4e4e"
    property color textColorDown: "#303030"
    property color textRaisedColorUp: "#ffffff"
    property color textRaisedColorDown: "#e3e3e3"

    property real minTextFontSize: 6
    property real textFontSize: toPixels(0.125)

    property real radius: (smallestAxis * 0.5) - outerArcLineWidth - innerArcLineWidth
    property real halfRadius: radius / 2
    property real outerArcRadius: innerArcRadius + outerArcLineWidth / 2
    property real innerArcRadius: radius + innerArcLineWidth / 2
    property real shineArcRadius: outerArcRadius + outerArcLineWidth / 2 - shineArcLineWidth / 2
    property real zeroAngle: Math.PI * 0.5

    property color buttonColorTop: control.pressed ? buttonColorDownTop : buttonColorUpTop
    property color buttonColorBottom: control.pressed ? buttonColorDownBottom : buttonColorUpBottom

    function toPixels(percentageOfSmallestAxis) {
        return percentageOfSmallestAxis * smallestAxis;
    }

    function paintBackground(ctx) {
        ctx.reset();

        var xCenter = ctx.canvas.width / 2;
        var yCenter = ctx.canvas.height / 2;

        /* Draw outer arc */
        ctx.beginPath();
        ctx.lineWidth = outerArcLineWidth;
        ctx.arc(xCenter, yCenter, outerArcRadius, 0, Math.PI * 2, false);
        var gradient = ctx.createRadialGradient(xCenter, yCenter - halfRadius,
            halfRadius, xCenter, yCenter - halfRadius, radius);
        gradient.addColorStop(0, outerArcColorTop);
        gradient.addColorStop(1, outerArcColorBottom);
        ctx.strokeStyle = gradient;
        ctx.stroke();

        /* Draw the shine along the bottom */
        ctx.beginPath();
        ctx.lineWidth = shineArcLineWidth;
        ctx.arc(xCenter, yCenter, shineArcRadius, 0, Math.PI, false);
        gradient = ctx.createLinearGradient(xCenter, yCenter + radius, xCenter, yCenter);
        gradient.addColorStop(0, shineColor);
        gradient.addColorStop(0.5, "rgba(255, 255, 255, 0)");
        ctx.strokeStyle = gradient;
        ctx.stroke();

        /* Draw inner arc */
        ctx.beginPath();
        ctx.lineWidth = innerArcLineWidth + 1;
        ctx.arc(xCenter, yCenter, innerArcRadius, 0, Math.PI * 2, false);
        gradient = ctx.createLinearGradient(xCenter, yCenter - halfRadius,
            xCenter, yCenter + halfRadius);
        gradient.addColorStop(0, innerArcColorTop);
        gradient.addColorStop(innerArcColorBottomStop, innerArcColorBottom);
        ctx.strokeStyle = gradient;
        ctx.stroke();

        /* Draw the button's body */
        ctx.beginPath();
        ctx.ellipse(xCenter - radius, yCenter - radius, radius * 2, radius * 2);
        gradient = ctx.createRadialGradient(xCenter, yCenter + radius * 0.85, radius,
            xCenter, yCenter + radius * 0.85, radius * 0.85);
        gradient.addColorStop(1, buttonColorTop);
        gradient.addColorStop(0, buttonColorBottom);
        ctx.fillStyle = gradient;
        ctx.fill();
    }
}
