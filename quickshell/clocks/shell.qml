// World clocks — a drawer on the right screen edge, fully hidden until the
// pointer touches that edge, then sliding out to the full card.
//
// Run with:  qs -c clocks
//
// All timezone handling lives in scripts/clocks.sh, not here: Qt 6's QML engine
// ships no Intl implementation and exposes no QTimeZone binding, so
// Qt.formatDateTime() can only render local time. This file just renders rows.
//
// The card is clear glass: a light blur of whatever is behind it, barely tinted.
// The blur is mango's, not ours -- a client cannot see past its own surface --
// and mango/config.conf enables it for this widget's layer namespace only.

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

ShellRoot {
    id: root

    // Rows produced by scripts/clocks.sh. To add or remove a city, edit that
    // script's ZONES list -- nothing in this file needs to change.
    property var zones: []

    // Light text on clear glass. The glass is too clear to promise any one
    // backdrop, so what keeps text readable is the shadow every glyph casts
    // (colTextShadow), not the glass.
    // colAccent is waybar's #8abeb7 lightened a little, for the pin and the
    // local zone's time.
    readonly property color colFg: "#f4f5f5"
    readonly property color colDim: "#dfe1e3"
    readonly property color colAccent: "#a3e0d6"
    // A hard black copy of every glyph, a pixel right and a pixel down,
    // unblurred. Over a dark window it vanishes into the dark; over a white
    // one it is the edge the light text reads by.
    readonly property color colTextShadow: "#000000"
    // Glass tones. colBg smokes the glass with the desktop's #1d1f21, over
    // mango's plain blur (mango/config.conf: light, no darkening, no grain):
    // a white window behind turns dark grey, which also helps the light text.
    readonly property color colBg: "#b31d1f21"         // #1d1f21 at 0.7 alpha
    // A little more of it, under the card: the shadow surface fills the gap
    // it leaves for the card with it (see there). The card's blur takes it in.
    readonly property color colUnderTint: "#661d1f21"  // #1d1f21 at 0.4 alpha
    readonly property color colHeaderBg: "#0affffff"   // white at ~0.04 alpha: a lighter title strip
    readonly property color colRowHover: "#1fffffff"   // white at ~0.12 alpha: a lit pane of glass
    readonly property color colEdge: "#5a5d61"         // solid dark grey: the card's border
    readonly property color colDivider: "#33ffffff"    // white at 0.2 alpha: header/rows seam
    readonly property color colSeparator: "#1fffffff"  // white at ~0.12 alpha: between rows
    readonly property color colSheenTop: "#1affffff"   // white at 0.1 alpha
    readonly property color colSheenBottom: "#00ffffff"
    // Fira Sans for text, the sans sibling of the FiraCode used across the
    // desktop; the Nerd Font only for the pin glyphs, which Fira Sans lacks.
    readonly property string uiFont: "Fira Sans"
    readonly property string iconFont: "FiraCode Nerd Font"
    readonly property int uiSize: 13
    readonly property int timeSize: 26

    // The content width is fixed rather than measured, so the header can span
    // a full row without binding to the Column that contains it, which would
    // be circular. It fits "Vladivostok" beside a full-size time with room to
    // spare; a longer city elides.
    readonly property int padding: 16
    readonly property int rowWidth: 232
    // Room the city column leaves for the time on its right.
    readonly property int wLabel: rowWidth - 84
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

        // The shadow. Text.Raised offers only a straight-down one, hence the
        // effect. Its blurMax is no blur -- shadowBlur is 0 -- but the room
        // the layer is padded by, which only has to fit the offset.
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: root.colTextShadow
            shadowBlur: 0
            blurMax: 2
            shadowHorizontalOffset: 1
            shadowVerticalOffset: 1
        }
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
            // Three surfaces per screen: the card, its shadows, and an
            // invisible one that takes the drawer's input. The card and its
            // shadows must move in step, and a surface whose input region
            // changes has its next frames reach the screen late (~100ms,
            // measured here under mango) -- so neither of them takes input
            // at all, and the region that has to change as the drawer opens
            // and closes lives on a surface that draws nothing.
            Scope {
                id: perScreen

                // The screen from Quickshell.screens is injected here.
                required property var modelData

                // The card's drop shadows, in a surface of their own. mango blurs
                // behind every pixel of a blurred surface that is not fully
                // transparent, so in the card's surface the shadows would get a
                // hard-edged blur out to where they fade. This surface keeps the
                // default namespace, which mango does not blur. Sized and anchored
                // like the card's surface, it lies exactly under it, and the
                // shadows follow the card as it slides.
                //
                // Separate surfaces do not always reach the screen in the same
                // frame, though: mid-slide, the shadows now and then land a
                // frame ahead of the card or behind it. The card-shaped gap cut
                // in them then misses the card, and through it the screen
                // flashed beside the card, bright against the dark shadow. So
                // the gap is never left empty: it holds colUnderTint, which the
                // card covers when the two are in step and which, when they
                // are not, shows as a strip of the glass's tint, not a hole.
                PanelWindow {
                    screen: perScreen.modelData
                    visible: panel.visible

                    anchors {
                        right: true
                    }

                    exclusiveZone: 0
                    color: "transparent"
                    implicitWidth: panel.implicitWidth
                    implicitHeight: panel.implicitHeight

                    // Empty, so it takes no input at all: hover and clicks reach
                    // the hit surface or the windows underneath.
                    mask: Region {}

                    // Stands in for the card, so the shadow items keep their
                    // card-relative coordinates.
                    Item {
                        x: card.x
                        y: card.y
                        width: card.width
                        height: card.height

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
                                color: "#73000000" // black at 0.45 alpha
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
                                color: "#40000000" // black at 0.25 alpha
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

                        // The tint that fills that cutout.
                        Shape {
                            anchors.fill: parent
                            preferredRendererType: Shape.CurveRenderer

                            CardOutline {
                                w: card.width
                                h: card.height
                                fillColor: root.colUnderTint
                            }
                        }
                    }
                }

                PanelWindow {
                    id: panel

                    screen: perScreen.modelData

                    // A name of its own, so mango's layer rules can blur behind
                    // this widget and nothing else (see the blur section of
                    // mango/config.conf). Every other quickshell surface keeps the
                    // default "quickshell".
                    WlrLayershell.namespace: "quickshell-clocks"

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
                    // its shadow on every side but the screen edge, which the shadow
                    // surface (declared before this one) draws into this footprint.
                    implicitWidth: card.width + root.shadowSize
                    implicitHeight: card.height + (root.cornerRadius + root.shadowSize) * 2

                    // Toggled by the header's pin: a pinned drawer stays out after
                    // the pointer leaves. Per panel, so each screen pins on its own.
                    property bool pinned: false
                    readonly property bool expanded: hover.containsMouse || panel.pinned

                    // The pointer, as the hit surface sees it, in card coordinates.
                    // The surfaces lie exactly over each other, so its window
                    // coordinates are this window's too.
                    readonly property point pointer: Qt.point(hover.mouseX - card.x, hover.mouseY - card.y)
                    readonly property bool pinHovered: hover.containsMouse
                        && pinIcon.contains(pinIcon.mapFromItem(card, panel.pointer))

                    // Empty: all input goes to the hit surface (see the Scope above).
                    mask: Region {}

                    Item {
                        id: card

                        // Closed, the whole card is past the right edge of the
                        // surface and clipped away -- far enough that its shadow's
                        // blur goes too; only the hit surface's edge strip
                        // remains, invisible but hoverable.
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

                            // A faint top-down sheen over the tint. It fades to
                            // nothing rather than to a hard band, which is what
                            // keeps the glass matte instead of glossy.
                            CardOutline {
                                w: card.width
                                h: card.height
                                fillGradient: LinearGradient {
                                    x1: 0; y1: 0
                                    x2: 0; y2: card.height
                                    GradientStop { position: 0; color: root.colSheenTop }
                                    GradientStop { position: 1; color: root.colSheenBottom }
                                }
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
                                height: headerText.implicitHeight + 14
                                // Square except the corner it shares with the
                                // card, which would otherwise poke past the card's.
                                topLeftRadius: root.cornerRadius
                                color: root.colHeaderBg

                                // Pin toggle: outline while unpinned, filled in
                                // the accent colour while pinned. Padded rather
                                // than offset, so the glyph lines up with the
                                // labels below while the whole padded box, at
                                // the full header height, takes the click (on
                                // the hit surface, through panel.pinHovered).
                                Cell {
                                    id: pinIcon

                                    anchors.left: parent.left
                                    height: parent.height
                                    leftPadding: root.padding
                                    rightPadding: root.padding

                                    text: panel.pinned ? "󰐃" : "󰤱"
                                    font.family: root.iconFont
                                    color: panel.pinned || panel.pinHovered ? root.colAccent : root.colDim
                                }

                                Cell {
                                    id: headerText

                                    anchors.right: parent.right
                                    anchors.rightMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    text: "WORLD CLOCKS"
                                    font.pixelSize: (root.uiSize - 3) * 1.5
                                    font.weight: Font.Black
                                    font.italic: true
                                    font.letterSpacing: 1.5
                                }

                                // Hairline seam between the header and the rows.
                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    width: parent.width
                                    height: 1
                                    color: root.colDivider
                                }
                            }

                            // Rows sit edge to edge, each 16px taller than its text,
                            // so a hovered row's lit fill has no gaps around it.
                            Column {
                                id: rows

                                width: parent.width

                                Repeater {
                                    model: root.zones

                                    Rectangle {
                                        id: clockRow

                                        required property var modelData
                                        required property int index

                                        // The zone this machine is in: scripts/clocks.sh
                                        // writes "same" for a zero offset from local time.
                                        readonly property bool isLocal: clockRow.modelData.delta === "same"

                                        width: rows.width
                                        height: place.implicitHeight + 16
                                        // Square, except the last row's corner it
                                        // shares with the card, which would otherwise
                                        // poke past the card's.
                                        bottomLeftRadius: clockRow.index === root.zones.length - 1 ? root.cornerRadius : 0
                                        color: hover.containsMouse && clockRow.contains(clockRow.mapFromItem(card, panel.pointer))
                                            ? root.colRowHover : "transparent"

                                        // Hairline between rows, inset to the text.
                                        Rectangle {
                                            visible: clockRow.index > 0
                                            x: root.padding
                                            width: parent.width - root.padding * 2
                                            height: 1
                                            color: root.colSeparator
                                        }

                                        // City over a quiet "day · zone · offset" line.
                                        Column {
                                            id: place

                                            x: root.padding
                                            anchors.verticalCenter: parent.verticalCenter
                                            spacing: 1

                                            Cell {
                                                width: root.wLabel
                                                text: clockRow.modelData.label
                                                font.pixelSize: root.uiSize + 2
                                                font.weight: Font.Medium
                                                elide: Text.ElideRight
                                            }

                                            Cell {
                                                width: root.wLabel
                                                text: [clockRow.modelData.day, clockRow.modelData.abbr,
                                                    clockRow.isLocal ? "local" : clockRow.modelData.delta].join("  ·  ")
                                                color: root.colDim
                                                font.pixelSize: root.uiSize - 2
                                                elide: Text.ElideRight
                                            }
                                        }

                                        Cell {
                                            anchors.right: parent.right
                                            anchors.rightMargin: root.padding
                                            anchors.verticalCenter: parent.verticalCenter

                                            text: clockRow.modelData.time
                                            color: clockRow.isLocal ? root.colAccent : root.colFg
                                            font.pixelSize: root.timeSize
                                            font.weight: Font.Light
                                            // Tabular digits, so the colons line up
                                            // down the column.
                                            font.features: { "tnum": 1 }
                                        }
                                    }
                                }
                            }
                        }

                        // The glass's cut edge: a hairline traced along the
                        // card's outline, over the header and rows. The outline
                        // is an open path, so no line is drawn down the screen
                        // edge; it runs out along the inverted corners instead.
                        Shape {
                            anchors.fill: parent
                            preferredRendererType: Shape.CurveRenderer

                            CardOutline {
                                w: card.width
                                h: card.height
                                fillColor: "transparent"
                                strokeColor: root.colEdge
                                strokeWidth: 1
                            }
                        }
                    }
                }

                // The hit surface: takes every bit of the drawer's input for the
                // card and shadow surfaces, which take none (see the Scope
                // above). It draws nothing. Sized and anchored like them.
                PanelWindow {
                    id: hitSurface

                    screen: perScreen.modelData
                    visible: panel.visible

                    anchors {
                        right: true
                    }

                    exclusiveZone: 0
                    color: "transparent"
                    implicitWidth: panel.implicitWidth
                    implicitHeight: panel.implicitHeight

                    // Only the card's footprint takes input; clicks on the
                    // transparent rest fall through to the windows underneath.
                    // Closed, that is a thin strip along the screen edge, so
                    // pushing the pointer against the edge opens the drawer.
                    // Bound to the target state rather than to the animating
                    // card, so the hit area does not shrink mid-slide. The
                    // shadow margin is left out, so the shadow takes no clicks.
                    mask: Region {
                        x: panel.expanded ? root.shadowSize : hitSurface.width - root.edgeWidth
                        y: root.shadowSize
                        width: panel.expanded ? card.width : root.edgeWidth
                        height: hitSurface.height - root.shadowSize * 2
                    }

                    MouseArea {
                        id: hover

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: panel.pinHovered ? Qt.PointingHandCursor : Qt.ArrowCursor

                        onClicked: {
                            if (panel.pinHovered)
                                panel.pinned = !panel.pinned;
                        }
                    }
                }
            }
        }
    }
}
