// World clocks — a drawer on the right screen edge, fully hidden until the
// pointer touches that edge, then sliding out to the full card.
//
// Run with:  qs -c clocks
//
// All timezone handling lives in scripts/clocks.sh, not here: Qt 6's QML engine
// ships no Intl implementation and exposes no QTimeZone binding, so
// Qt.formatDateTime() can only render local time. This file just renders rows.

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

ShellRoot {
    id: root

    // Rows produced by scripts/clocks.sh. To add or remove a city, edit that
    // script's ZONES list -- nothing in this file needs to change.
    property var zones: []

    // Palette and font lifted from waybar/style.css so the widget reads as part
    // of the same desktop rather than a stranger on it.
    readonly property color colFg: "#c5c8c6"
    // colDim and colBg depart from waybar: at waybar's ~0.667 alpha, a light
    // window behind the card blended it to ~#707174, the same grey as waybar's
    // #707880 dim text, which made that text vanish.
    readonly property color colDim: "#969896"
    readonly property color colAccent: "#8abeb7"
    readonly property color colBg: "#ee282a2e"       // #282a2e at ~0.933 alpha
    readonly property color colHeaderBg: "#cc0d0e10" // waybar's "much darker" tone
    readonly property color colRowHover: "#660d0e10" // header tone at ~0.4 alpha: darker than the card, lighter than the header
    readonly property string uiFont: "FiraCode Nerd Font"
    readonly property int uiSize: 13

    // Column widths are named so the header can span a full row without binding
    // to the Column that contains it, which would be circular.
    readonly property int wLabel: 104
    readonly property int wTime: 46
    readonly property int wDay: 32
    readonly property int wAbbr: 48
    readonly property int wDelta: 62
    readonly property int cellSpacing: 10
    readonly property int padding: 12
    readonly property int rowWidth: wLabel + wTime + wDay + wAbbr + wDelta + cellSpacing * 4
    // Invisible strip along the screen edge that still takes hover while the
    // drawer is closed, so pushing the pointer against the edge opens it.
    readonly property int edgeWidth: 2
    // Radius of the card's rounded outer corners, and of the inverted corners
    // that join it to the screen edge.
    readonly property int cornerRadius: 8
    // The wide, soft shadow that makes the card look lifted off the screen:
    // how far it blurs out, and how far it falls below the card.
    readonly property int shadowBlur: 40
    readonly property int shadowDrop: 12
    // Room left around the card for that shadow to blur into.
    readonly property int shadowSize: shadowBlur + shadowDrop

    component Cell: Text {
        color: root.colFg
        font.family: root.uiFont
        font.pixelSize: root.uiSize
        verticalAlignment: Text.AlignVCenter
    }

    component Corner: PathArc {
        radiusX: root.cornerRadius
        radiusY: root.cornerRadius
    }

    // The card's silhouette, w x h: rounded outer corners, and at the screen
    // edge (the right) inverted corners that flare out to meet it, reaching
    // cornerRadius above and below. Shared by the card's fill and by the mask
    // that keeps the shadow out from under the card.
    component CardOutline: ShapePath {
        id: outline

        property real w
        property real h

        strokeWidth: -1
        startX: outline.w
        startY: -root.cornerRadius

        Corner { x: outline.w - root.cornerRadius; y: 0 }
        PathLine { x: root.cornerRadius; y: 0 }
        Corner { x: 0; y: root.cornerRadius; direction: PathArc.Counterclockwise }
        PathLine { x: 0; y: outline.h - root.cornerRadius }
        Corner { x: root.cornerRadius; y: outline.h; direction: PathArc.Counterclockwise }
        PathLine { x: outline.w - root.cornerRadius; y: outline.h }
        Corner { x: outline.w; y: outline.h + root.cornerRadius }
    }

    SystemClock {
        id: clock
        // Minutes, not Seconds: the widget shows no seconds digit, so second
        // precision would wake it 60x more often to redraw identical text.
        precision: SystemClock.Minutes
    }

    // One helper run feeds every screen's panel: the process and the parsed rows
    // live here at the root, not inside the per-screen delegate.
    Process {
        id: zonesProc

        // Process.command does not run a shell, so the script goes through sh to
        // get $HOME expanded. Qt.resolvedUrl() would yield a file:// URL, which is
        // not a usable argv entry.
        command: ["sh", "-c", "exec \"$HOME/.config/quickshell/clocks/scripts/clocks.sh\""]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.zones = JSON.parse(text);
                } catch (e) {
                    console.warn("clocks: helper produced unparseable output:", e);
                }
            }
        }
    }

    // One refresh per minute tick, driven by the single clock so every row is
    // rendered from the same instant. The guard keeps a slow run from being
    // restarted on top of itself.
    Connections {
        target: clock

        function onDateChanged() {
            if (!zonesProc.running)
                zonesProc.running = true;
        }
    }

    // One panel per connected screen. Besides putting the widget on every
    // monitor, this is what makes it survive a disconnect/reconnect cycle --
    // without it the window may simply not come back when an output returns.
    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: panel

                // The screen from Quickshell.screens is injected here.
                required property var modelData

                screen: panel.modelData

                // Stay hidden until the first helper run lands, so no empty box
                // flashes on startup.
                visible: root.zones.length > 0

                // Anchored to the right edge only, so the layer-shell protocol
                // centers it vertically on that edge.
                anchors {
                    right: true
                }

                // aboveWindows is left at its default (true): on the bottom layer, a
                // window covering the right edge would hide the tab from the pointer.

                // An explicit zone of 0 reserves no space, so windows are never
                // pushed aside, while still keeping clear of waybar's exclusive zone.
                exclusiveZone: 0

                color: "transparent"

                // The surface is always sized for the expanded card and never moves
                // or resizes; the card slides inside it instead, so hovering costs
                // no compositor round-trip per animation frame. The extra size is
                // room for the inverted corners above and below the card, and for
                // its shadow on every side but the screen edge.
                implicitWidth: card.width + root.shadowSize
                implicitHeight: card.height + (root.cornerRadius + root.shadowSize) * 2

                readonly property bool expanded: hover.containsMouse

                // Only the visible part takes input; clicks on the transparent rest
                // fall through to the windows underneath. Bound to the target state
                // rather than to the animating card, so the hit area does not shrink
                // mid-slide.
                // The shadow margin is left out too, so the shadow takes no clicks.
                mask: Region {
                    x: panel.expanded ? root.shadowSize : panel.width - root.edgeWidth
                    y: root.shadowSize
                    width: panel.expanded ? card.width : root.edgeWidth
                    height: panel.height - root.shadowSize * 2
                }

                MouseArea {
                    id: hover

                    anchors.fill: parent
                    hoverEnabled: true

                    Item {
                        id: card

                        // Closed, the whole card is past the right edge of the
                        // surface and clipped away -- far enough that its shadow's
                        // blur goes too; only the mask's edge strip remains,
                        // invisible but hoverable.
                        x: panel.expanded ? root.shadowSize : panel.width + root.shadowBlur
                        y: root.shadowSize + root.cornerRadius
                        width: root.rowWidth + root.padding * 2
                        height: content.implicitHeight

                        Behavior on x {
                            NumberAnimation {
                                duration: 180
                                easing.type: Easing.OutCubic
                            }
                        }

                        // Drop shadows that float the card above the screen: a wide
                        // soft one falling below it, and a tight one hugging its edge.
                        // Shadow-only items rather than a MultiEffect shadow on the
                        // fill, which lightened the translucent fill itself. They
                        // follow the plain card; the inverted corners fall inside
                        // their blur. This item spans their whole reach (the panel's
                        // shadow margin), so its layer holds all of them.
                        Item {
                            x: -root.shadowSize
                            y: -root.cornerRadius - root.shadowSize
                            width: card.width + root.shadowSize
                            height: card.height + (root.cornerRadius + root.shadowSize) * 2

                            // The card's shape is cut out of the shadows: drawn under
                            // the translucent card, they would darken what shows
                            // through it until the card looked opaque.
                            layer.enabled: true
                            layer.effect: MultiEffect {
                                maskEnabled: true
                                maskInverted: true
                                maskSource: shadowCutout
                                // Cut only where the card covers a pixel fully. Its
                                // antialiased edge pixels keep the shadow under them;
                                // cutting those too lets the screen behind leak
                                // through as a light line along the curved corners.
                                maskThresholdMin: 0.99
                                // Unpadded, so the output stays the mask's size and
                                // the two line up.
                                autoPaddingEnabled: false
                            }

                            RectangularShadow {
                                x: root.shadowSize
                                y: root.shadowSize + root.cornerRadius
                                width: card.width
                                height: card.height
                                radius: root.cornerRadius
                                topRightRadius: 0
                                bottomRightRadius: 0
                                blur: root.shadowBlur
                                offset.y: root.shadowDrop
                                color: "#e6000000" // black at 0.9 alpha
                            }

                            RectangularShadow {
                                x: root.shadowSize
                                y: root.shadowSize + root.cornerRadius
                                width: card.width
                                height: card.height
                                radius: root.cornerRadius
                                topRightRadius: 0
                                bottomRightRadius: 0
                                blur: 8
                                offset.y: 3
                                color: "#80000000" // black at 0.5 alpha
                            }
                        }

                        // The mask for that cutout: the card's shape, opaque, over the
                        // same area as the shadows. Rendered only into its layer.
                        Item {
                            id: shadowCutout

                            x: -root.shadowSize
                            y: -root.cornerRadius - root.shadowSize
                            width: card.width + root.shadowSize
                            height: card.height + (root.cornerRadius + root.shadowSize) * 2
                            visible: false
                            layer.enabled: true

                            Shape {
                                x: root.shadowSize
                                y: root.shadowSize + root.cornerRadius
                                width: card.width
                                height: card.height
                                preferredRendererType: Shape.CurveRenderer

                                CardOutline {
                                    w: card.width
                                    h: card.height
                                    fillColor: "black"
                                }
                            }
                        }

                        // The card's fill. Drawn as one path, not a Rectangle plus
                        // corner pieces: translucent pieces abutting at a fractional
                        // device pixel (the screen is at 1.5x) would leave a visible
                        // seam between them.
                        Shape {
                            anchors.fill: parent
                            preferredRendererType: Shape.CurveRenderer // antialiased arcs

                            CardOutline {
                                w: card.width
                                h: card.height
                                fillColor: root.colBg
                            }

                            // The top inverted corner sits beside the header, so it
                            // also takes the header's darker fill on top.
                            ShapePath {
                                fillColor: root.colHeaderBg
                                strokeWidth: -1

                                startX: card.width
                                startY: -root.cornerRadius

                                Corner { x: card.width - root.cornerRadius; y: 0 }
                                PathLine { x: card.width; y: 0 }
                            }
                        }

                        Column {
                            id: content

                            width: parent.width
                            spacing: 0

                            // Header strip: spans the full card width so the darker
                            // fill reads as a title bar rather than a floating patch.
                            Rectangle {
                                id: header

                                width: parent.width
                                height: headerText.implicitHeight + 10
                                // Square except the corner it shares with the
                                // card, which would otherwise poke past the card's.
                                topLeftRadius: root.cornerRadius
                                color: root.colHeaderBg

                                Cell {
                                    id: headerText

                                    anchors.right: parent.right
                                    anchors.rightMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    text: "WORLD CLOCKS"
                                    color: root.colDim
                                    font.pixelSize: root.uiSize - 2
                                    font.bold: true
                                    // FiraCode ships no italic, so Qt slants it.
                                    font.italic: true
                                }
                            }

                            // Rows sit edge to edge, each 8px taller than its text, so
                            // a hovered row's darker fill has no gaps around it.
                            Column {
                                id: rows

                                width: parent.width

                                Repeater {
                                    model: root.zones

                                    Rectangle {
                                        id: clockRow

                                        required property var modelData
                                        required property int index

                                        width: rows.width
                                        height: cells.implicitHeight + 8
                                        // Square, except the last row's corner it
                                        // shares with the card, which would otherwise
                                        // poke past the card's.
                                        bottomLeftRadius: clockRow.index === root.zones.length - 1 ? root.cornerRadius : 0
                                        color: rowHover.hovered ? root.colRowHover : "transparent"

                                        HoverHandler {
                                            id: rowHover
                                        }

                                        Row {
                                            id: cells

                                            x: root.padding
                                            anchors.verticalCenter: parent.verticalCenter
                                            spacing: root.cellSpacing

                                            Cell {
                                                // Widest current label ("Vladivostok")
                                                // measures 88px in FiraCode Nerd Font 13px;
                                                // the slack keeps ElideRight from biting if
                                                // a longer city is added.
                                                width: root.wLabel
                                                text: clockRow.modelData.label
                                                elide: Text.ElideRight
                                            }

                                            Cell {
                                                width: root.wTime
                                                text: clockRow.modelData.time
                                                color: root.colAccent
                                            }

                                            Cell {
                                                width: root.wDay
                                                text: clockRow.modelData.day
                                                color: root.colDim
                                            }

                                            Cell {
                                                width: root.wAbbr
                                                text: clockRow.modelData.abbr
                                                color: root.colDim
                                            }

                                            Cell {
                                                width: root.wDelta
                                                text: clockRow.modelData.delta
                                                color: root.colDim
                                                horizontalAlignment: Text.AlignRight
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
