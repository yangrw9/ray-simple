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
    id: handleStyleHelper

    property color handleColorTop: "#969696"
    property color handleColorBottom: Qt.rgba(0.9, 0.9, 0.9, 0.298)
    property real handleColorBottomStop: 0.7

    property color handleRingColorTop: "#b0b0b0"
    property color handleRingColorBottom: "transparent"

    /*!
        If \a ctx is the only argument, this is equivalent to calling
        paintHandle(\c ctx, \c 0, \c 0, \c ctx.canvas.width, \c ctx.canvas.height).
    */
    function paintHandle(ctx, handleX, handleY, handleWidth, handleHeight) {
        ctx.reset();

        if (arguments.length == 1) {
            handleX = 0;
            handleY = 0;
            handleWidth = ctx.canvas.width;
            handleHeight = ctx.canvas.height;
        }

        ctx.beginPath();
        var gradient = ctx.createRadialGradient(handleX, handleY, handleWidth / 2,
            handleX, handleY, handleWidth);
        gradient.addColorStop(0, handleColorTop);
        gradient.addColorStop(handleColorBottomStop, handleColorBottom);
        ctx.ellipse(handleX, handleY, handleWidth, handleHeight);
        ctx.fillStyle = gradient;
        ctx.fill();

        /* Draw the ring gradient around the handle. */
        // Clip first, so we only draw inside the ring.
        ctx.beginPath();
        ctx.ellipse(handleX, handleY, handleWidth, handleHeight);
        ctx.ellipse(handleX + 2, handleY + 2, handleWidth - 4, handleHeight - 4);
        ctx.clip();

        ctx.beginPath();
        gradient = ctx.createLinearGradient(handleX + handleWidth / 2, handleY,
            handleX + handleWidth / 2, handleY + handleHeight);
        gradient.addColorStop(0, handleRingColorTop);
        gradient.addColorStop(1, handleRingColorBottom);
        ctx.ellipse(handleX, handleY, handleWidth, handleHeight);
        ctx.fillStyle = gradient;
        ctx.fill();
    }
}
