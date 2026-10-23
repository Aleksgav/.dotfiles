// Window-layout minimap — a drawer on the left screen edge, fully hidden until
// the pointer touches that edge, then sliding out to a scaled-down map of the
// windows on the monitor's current tag. Under the map, a strip of layout chips
// shows the current tag's layout and sets another on click. A footer of dots,
// one per tag, previews a tag's windows in the map on hover and switches to
// that tag on click.
//
// Run with:  qs -c layout
//
// Everything shown comes from mango's IPC (mmsg). Its `watch` streams print the
// full current state once on start, then again on every change.
//
// Styled like clocks/shell.qml: the card is smoked glass over a light blur of
// whatever is behind it. The blur is mango's, not ours -- a client cannot see
// past its own surface -- and mango/config.conf enables it for this widget's
// and the clocks' layer namespaces only.

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

ShellRoot {
    id: root

    // Latest state from mmsg, shared by every screen's drawer.
    property var clients: []
    property var monitors: []
    // Layout symbol -> full name ("RT" -> "right_tile"), from `mmsg get layouts`.
    property var layoutNames: ({})
    // Tag number -> label, copied from ext/workspaces' format-icons in
    // waybar/config.jsonc so tags read the same here as on the bar.
    readonly property var tagNames: ({
        "1": "󰋜 home",
        "2": "󰍡 mess",
        "3": "󰙀 proj",
        "4": "󰂻 learn",
        "5": "󰂺 read",
        "6": "󰸼 cross",
        "7": "󰋑 hearth",
        "8": "󰒓 conf",
        "9": "󰇘 other"
    })

    // Every layout mango has, by name, in its own order -- what the strip under
    // the map offers. From `mmsg get layouts`, like layoutNames.
    property var layoutChoices: []

    // Palette and fonts lifted from clocks/shell.qml, so the two drawers match.
    // Duplicated rather than shared: the two configs run as separate qs
    // instances.
    //
    // Light text on clear glass. The glass is too clear to promise any one
    // backdrop, so what keeps text readable is the shadow every glyph casts
    // (colTextShadow), not the glass.
    readonly property color colFg: "#f4f5f5"
    readonly property color colDim: "#dfe1e3"
    readonly property color colAccent: "#a3e0d6"
    // A hard black copy of every glyph, a pixel right and a pixel down,
    // unblurred. Over a dark window it vanishes into the dark; over a white
    // one it is the edge the light text reads by.
    readonly property color colTextShadow: "#000000"
    // Glass tones. colBg smokes the glass with the desktop's #1d1f21, over
    // mango's plain blur (mango/config.conf: light, no darkening, no grain).
    readonly property color colBg: "#b31d1f21"         // #1d1f21 at 0.7 alpha
    // A little more of it, under the card: the shadow surface fills the gap
    // it leaves for the card with it (see there). The card's blur takes it in.
    readonly property color colUnderTint: "#661d1f21"  // #1d1f21 at 0.4 alpha
    readonly property color colHeaderBg: "#0affffff"   // white at ~0.04 alpha: a lighter title strip
    readonly property color colEdge: "#5a5d61"         // solid dark grey: the card's border
    readonly property color colDivider: "#33ffffff"    // white at 0.2 alpha: header/map seam
    readonly property color colSheenTop: "#1affffff"   // white at 0.1 alpha
    readonly property color colSheenBottom: "#00ffffff"
    // The map: the screen as a darker pane sunk into the glass, its windows as
    // lighter panes on it.
    readonly property color colMapBg: "#40000000"      // black at 0.25 alpha
    readonly property color colWin: "#1fffffff"        // white at ~0.12 alpha
    readonly property color colWinBorder: "#8a8d91"
    readonly property color colWinFocused: "#4da3e0d6" // colAccent at 0.3 alpha
    readonly property color colUrgent: "#a54242"       // waybar's urgent-tag red
    readonly property color colEmpty: "#4dffffff"      // white at 0.3 alpha
    // Fira Sans for text, the sans sibling of the FiraCode used across the
    // desktop. The tag icons come from the Nerd Font by fallback.
    readonly property string uiFont: "Fira Sans"
    readonly property int uiSize: 13

    readonly property int mapWidth: 280
    readonly property int padding: 12
    // Footer dots, one per tag: their diameter, the active tag's stretched
    // width, and the gap between them.
    readonly property int dotSize: 8
    readonly property int dotActiveWidth: 24
    readonly property int dotGap: 8
    // Layout chips: small, four to a row across the map's width.
    readonly property int chipGap: 4
    readonly property int chipHeight: 18
    readonly property real chipWidth: (mapWidth - chipGap * 3) / 4
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
    // edge (the left) inverted corners that flare out to meet it, reaching
    // cornerRadius above and below. Shared by the card's fill, its border,
    // and by the mask that keeps the shadow out from under the card.
    component CardOutline: ShapePath {
        id: outline

        property real w
        property real h

        strokeWidth: -1
        startX: 0
        startY: -root.cornerRadius

        Corner { x: root.cornerRadius; y: 0; direction: PathArc.Counterclockwise }
        PathLine { x: outline.w - root.cornerRadius; y: 0 }
        Corner { x: outline.w; y: root.cornerRadius }
        PathLine { x: outline.w; y: outline.h - root.cornerRadius }
        Corner { x: outline.w - root.cornerRadius; y: outline.h }
        PathLine { x: root.cornerRadius; y: outline.h }
        Corner { x: 0; y: outline.h + root.cornerRadius; direction: PathArc.Counterclockwise }
    }

    // "center_tile" -> "Center tile". The vertical variants trade the word
    // for an arrow, "vertical_grid" -> "↕ Grid", so every label fits a chip.
    function layoutLabel(name) {
        const vertical = name.startsWith("vertical_");
        const words = (vertical ? name.slice("vertical_".length) : name).replace(/_/g, " ");
        return (vertical ? "↕ " : "") + words.charAt(0).toUpperCase() + words.slice(1);
    }

    function parse(what, text) {
        try {
            return JSON.parse(text);
        } catch (e) {
            console.warn("layout: unparseable mmsg " + what + " output:", e);
            return null;
        }
    }

    Process {
        id: clientsWatch

        command: ["mmsg", "watch", "all-clients"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const msg = root.parse("all-clients", data);
                if (msg)
                    root.clients = msg.clients;
            }
        }
    }

    Process {
        id: monitorsWatch

        command: ["mmsg", "watch", "all-monitors"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const msg = root.parse("all-monitors", data);
                if (!msg)
                    return;
                root.monitors = msg.monitors;
                // A layout or tag switch moves windows, and it is not confirmed
                // that the all-clients stream fires for pure geometry changes --
                // so every monitor event also re-reads the client list.
                if (!clientsGet.running)
                    clientsGet.running = true;
            }
        }
    }

    Process {
        id: clientsGet

        command: ["mmsg", "get", "all-clients"]

        stdout: StdioCollector {
            onStreamFinished: {
                const msg = root.parse("all-clients", text);
                if (msg)
                    root.clients = msg.clients;
            }
        }
    }

    Process {
        command: ["mmsg", "get", "layouts"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const msg = root.parse("layouts", text);
                if (!msg)
                    return;
                const names = {};
                for (const l of msg.layouts)
                    names[l.symbol] = l.name;
                root.layoutNames = names;
                root.layoutChoices = msg.layouts.map(l => l.name);
            }
        }
    }

    // If a watch's mmsg exits (e.g. the compositor socket went away), start it
    // again instead of leaving the drawer frozen on stale state.
    Timer {
        interval: 2000
        repeat: true
        running: !clientsWatch.running || !monitorsWatch.running

        onTriggered: {
            if (!clientsWatch.running)
                clientsWatch.running = true;
            if (!monitorsWatch.running)
                monitorsWatch.running = true;
        }
    }

    // One drawer per connected screen, each mapping its own monitor.
    Variants {
        model: Quickshell.screens

        delegate: Component {
            // Three surfaces per screen, as in clocks/shell.qml: the card, its
            // shadows, and an invisible one that takes the drawer's input. The
            // card and its shadows must move in step, and a surface whose input
            // region changes has its next frames reach the screen late (~100ms,
            // measured under mango) -- so neither of them takes input at all,
            // and the region that has to change as the drawer opens and closes
            // lives on a surface that draws nothing.
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
                // frame ahead of the card or behind it. So the card-shaped gap
                // cut in them is never left empty: it holds colUnderTint, which
                // the card covers when the two are in step and which, when they
                // are not, shows as a strip of the glass's tint, not a hole.
                PanelWindow {
                    screen: perScreen.modelData
                    visible: panel.visible

                    anchors {
                        left: true
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
                                y: root.shadowSize + root.cornerRadius
                                width: card.width
                                height: card.height
                                radius: root.cornerRadius
                                topLeftRadius: 0
                                bottomLeftRadius: 0
                                blur: root.shadowBlur
                                offset.y: root.shadowDrop
                                color: "#73000000" // black at 0.45 alpha
                            }

                            RectangularShadow {
                                y: root.shadowSize + root.cornerRadius
                                width: card.width
                                height: card.height
                                radius: root.cornerRadius
                                topLeftRadius: 0
                                bottomLeftRadius: 0
                                blur: 8
                                offset.y: 3
                                color: "#40000000" // black at 0.25 alpha
                            }
                        }

                        // The mask for that cutout: the card's shape, opaque, over the
                        // same area as the shadows. Rendered only into its layer.
                        Item {
                            id: shadowCutout

                            y: -root.cornerRadius - root.shadowSize
                            width: card.width + root.shadowSize
                            height: card.height + (root.cornerRadius + root.shadowSize) * 2
                            visible: false
                            layer.enabled: true

                            Shape {
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
                    // this widget (see the blur section of mango/config.conf).
                    // Every other quickshell surface keeps the default
                    // "quickshell".
                    WlrLayershell.namespace: "quickshell-layout"

                    // This screen's entry in mango's monitor list, matched by output
                    // name ("HDMI-A-1"). Hidden until it is found.
                    readonly property var mon: root.monitors.find(m => m.name === perScreen.modelData.name) || null
                    readonly property real scale: panel.mon ? root.mapWidth / panel.mon.width : 0
                    readonly property int monX: panel.mon ? panel.mon.x : 0
                    readonly property int monY: panel.mon ? panel.mon.y : 0

                    // The pointer, as the hit surface sees it, in card coordinates.
                    // The surfaces lie exactly over each other, so its window
                    // coordinates are this window's too.
                    readonly property point pointer: Qt.point(hover.mouseX - card.x, hover.mouseY - card.y)

                    // Tag of the footer dot under the pointer, or 0. Read off the
                    // hit surface's one MouseArea rather than a MouseArea per dot,
                    // so the hover that keeps the drawer open is never handed to a
                    // child.
                    readonly property int hoveredTag: {
                        if (!hover.containsMouse)
                            return 0;
                        const p = dots.mapFromItem(card, panel.pointer);
                        const dot = dots.childAt(p.x, p.y);
                        return dot && dot.tag ? dot.tag : 0;
                    }
                    // The current tag's layout, by name -- the one a chip click
                    // replaces, so the strip shows it even while a dot preview
                    // puts another tag in the map and header.
                    readonly property string currentLayout: panel.mon ? (root.layoutNames[panel.mon.layout_symbol] || "") : ""
                    // Layout of the chip under the pointer, or "". Found the way
                    // hoveredTag finds its dot.
                    readonly property string hoveredLayout: {
                        if (!hover.containsMouse)
                            return "";
                        const p = chips.mapFromItem(card, panel.pointer);
                        const chip = chips.childAt(p.x, p.y);
                        return chip && chip.layoutName ? chip.layoutName : "";
                    }
                    // A dot of a tag not on screen is hovered: the map and header show
                    // that tag instead. Windows on hidden tags keep their last geometry.
                    readonly property bool previewing: panel.hoveredTag > 0 && panel.mon !== null
                        && !panel.mon.active_tags.includes(panel.hoveredTag)

                    // Windows shown on this monitor right now, or on the previewed tag;
                    // floating ones last so they draw on top of the tiled ones, as on
                    // screen. Hidden scratchpads have no tags, so a preview skips them.
                    readonly property var windows: panel.mon
                        ? root.clients
                            .filter(c => c.monitor === panel.mon.name && !c.is_minimized
                                && (panel.previewing ? c.tags.includes(panel.hoveredTag) : c.is_visible))
                            .sort((a, b) => a.is_floating - b.is_floating)
                        : []

                    visible: panel.mon !== null

                    // Anchored to the left edge only, so the layer-shell protocol
                    // centers it vertically on that edge.
                    anchors {
                        left: true
                    }

                    // aboveWindows is left at its default (true): on the bottom layer, a
                    // window covering the left edge would hide the tab from the pointer.

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

                    readonly property bool expanded: hover.containsMouse

                    // Empty: all input goes to the hit surface (see the Scope above).
                    mask: Region {}

                    Item {
                        id: card

                        // Closed, the whole card is past the left edge of the
                        // surface and clipped away -- far enough that its shadow's
                        // blur goes too; only the hit surface's edge strip
                        // remains, invisible but hoverable.
                        x: panel.expanded ? 0 : -width - root.shadowBlur
                        y: root.shadowSize + root.cornerRadius
                        width: content.width
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
                            // also takes the header's fill on top.
                            ShapePath {
                                fillColor: root.colHeaderBg
                                strokeWidth: -1

                                startX: 0
                                startY: -root.cornerRadius

                                Corner { x: root.cornerRadius; y: 0; direction: PathArc.Counterclockwise }
                                PathLine { x: 0; y: 0 }
                            }
                        }

                        Column {
                            id: content

                            width: root.mapWidth + root.padding * 2
                            spacing: 0

                            // Header strip: layout name on the left, tag on
                            // the right.
                            Rectangle {
                                width: parent.width
                                height: layoutText.implicitHeight + 14
                                // Square except the corner it shares with the
                                // card, which would otherwise poke past the card's.
                                topRightRadius: root.cornerRadius
                                color: root.colHeaderBg

                                // The layout name is the drawer's title, set
                                // like the clocks' "WORLD CLOCKS".
                                Cell {
                                    id: layoutText

                                    anchors.left: parent.left
                                    anchors.leftMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    // "tile" -> "[Tile]"
                                    text: {
                                        if (!panel.mon)
                                            return "";
                                        const tag = panel.previewing ? panel.mon.tags.find(t => t.index === panel.hoveredTag) : null;
                                        const symbol = tag ? tag.layout : panel.mon.layout_symbol;
                                        const name = root.layoutNames[symbol] || symbol;
                                        return "[" + name.charAt(0).toUpperCase() + name.slice(1) + "]";
                                    }
                                    font.pixelSize: (root.uiSize - 3) * 1.5
                                    font.weight: Font.Black
                                    font.italic: true
                                    font.letterSpacing: 1.5
                                }

                                Cell {
                                    anchors.right: parent.right
                                    anchors.rightMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    text: panel.mon
                                        ? (panel.previewing ? [panel.hoveredTag] : panel.mon.active_tags)
                                            .map(t => root.tagNames[t] || t).join("  ")
                                        : ""
                                    color: root.colDim
                                    font.pixelSize: root.uiSize - 2
                                }

                                // Hairline seam between the header and the map.
                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    width: parent.width
                                    height: 1
                                    color: root.colDivider
                                }
                            }

                            Item {
                                width: parent.width
                                height: map.height + root.padding * 2

                                // The monitor, scaled down to mapWidth. Clipped, as the
                                // screen is: a window partly off the monitor (a
                                // scroller's neighbours, a floating window pushed
                                // past the edge, one mid-animation) shows only its
                                // on-screen part instead of spilling out of the card.
                                Rectangle {
                                    id: map

                                    x: root.padding
                                    y: root.padding
                                    width: root.mapWidth
                                    height: panel.mon ? Math.round(panel.mon.height * panel.scale) : 0
                                    radius: 2
                                    color: root.colMapBg
                                    clip: true

                                    Repeater {
                                        model: panel.windows

                                        // One box per window at its real position and
                                        // size, inset 1px so neighbours read apart.
                                        Rectangle {
                                            id: win

                                            required property var modelData

                                            x: (win.modelData.x - panel.monX) * panel.scale + 1
                                            y: (win.modelData.y - panel.monY) * panel.scale + 1
                                            width: Math.max(win.modelData.width * panel.scale - 2, 1)
                                            height: Math.max(win.modelData.height * panel.scale - 2, 1)
                                            radius: 2
                                            color: win.modelData.is_focused ? root.colWinFocused : root.colWin
                                            border.width: 1
                                            border.color: win.modelData.is_focused ? root.colAccent : root.colWinBorder
                                            clip: true

                                            Cell {
                                                anchors.fill: parent
                                                anchors.margins: 2
                                                text: win.modelData.appid
                                                color: win.modelData.is_focused ? root.colFg : root.colDim
                                                font.pixelSize: 10
                                                horizontalAlignment: Text.AlignHCenter
                                                elide: Text.ElideRight
                                            }
                                        }
                                    }

                                    Cell {
                                        anchors.centerIn: parent
                                        visible: panel.windows.length === 0
                                        text: "empty"
                                        color: root.colDim
                                        font.pixelSize: root.uiSize - 2
                                    }
                                }
                            }

                            // The layout strip: a chip per layoutChoices entry, the
                            // current tag's layout filled in the accent colour, a
                            // hovered one lit. Clicked on the hit surface.
                            Item {
                                width: parent.width
                                height: chips.height + root.padding / 2

                                Grid {
                                    id: chips

                                    x: root.padding
                                    columns: 4
                                    columnSpacing: root.chipGap
                                    rowSpacing: root.chipGap

                                    Repeater {
                                        model: root.layoutChoices

                                        Rectangle {
                                            id: chip

                                            required property string modelData
                                            readonly property string layoutName: chip.modelData
                                            readonly property bool current: panel.currentLayout === chip.layoutName
                                            readonly property bool hovered: panel.hoveredLayout === chip.layoutName

                                            width: root.chipWidth
                                            height: root.chipHeight
                                            radius: 3
                                            color: chip.current ? root.colWinFocused
                                                : chip.hovered ? root.colWin
                                                : "transparent"
                                            border.width: 1
                                            border.color: chip.current ? root.colAccent : root.colEdge

                                            Behavior on color {
                                                ColorAnimation {
                                                    duration: 120
                                                }
                                            }

                                            Cell {
                                                anchors.centerIn: parent
                                                text: root.layoutLabel(chip.layoutName)
                                                color: chip.current || chip.hovered ? root.colFg : root.colDim
                                                font.pixelSize: 10
                                            }
                                        }
                                    }
                                }
                            }

                            // Footer: a dot per tag -- the active one stretched and
                            // accent-coloured, occupied ones bright, empty ones faint.
                            Item {
                                width: parent.width
                                height: root.dotSize + root.padding

                                Row {
                                    id: dots

                                    anchors.horizontalCenter: parent.horizontalCenter
                                    height: parent.height

                                    // Modelled on the tag count, not the tags array:
                                    // that is a new array on every monitor event, which
                                    // would rebuild the dots and cut their animations.
                                    Repeater {
                                        model: panel.mon ? panel.mon.tag_num : 0

                                        // Wider and taller than the dot it holds, so
                                        // it is easier to hit; hoveredTag finds it by
                                        // position and reads its tag.
                                        Item {
                                            id: dot

                                            required property int index
                                            readonly property int tag: dot.index + 1
                                            readonly property var info: (panel.mon ? panel.mon.tags.find(t => t.index === dot.tag) : null) || {}
                                            readonly property bool hovered: panel.hoveredTag === dot.tag

                                            width: pill.width + root.dotGap
                                            height: dots.height

                                            Rectangle {
                                                id: pill

                                                anchors.horizontalCenter: parent.horizontalCenter
                                                width: dot.info.is_active ? root.dotActiveWidth : root.dotSize
                                                height: root.dotSize
                                                radius: height / 2
                                                scale: dot.hovered && !dot.info.is_active ? 1.3 : 1
                                                color: dot.info.is_urgent ? root.colUrgent
                                                    : dot.info.is_active ? root.colAccent
                                                    : dot.info.client_count > 0 || dot.hovered ? root.colFg
                                                    : root.colEmpty

                                                Behavior on width {
                                                    NumberAnimation {
                                                        duration: 180
                                                        easing.type: Easing.OutCubic
                                                    }
                                                }

                                                Behavior on scale {
                                                    NumberAnimation {
                                                        duration: 120
                                                        easing.type: Easing.OutCubic
                                                    }
                                                }

                                                Behavior on color {
                                                    ColorAnimation {
                                                        duration: 180
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        // The card's border: a line traced along its outline,
                        // over the header and map. The outline is an open path,
                        // so no line is drawn down the screen edge; it runs out
                        // along the inverted corners instead.
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
                        left: true
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
                    // shadow margin is left out, so the shadow takes no clicks;
                    // the inverted corners above and below the card are in.
                    mask: Region {
                        x: 0
                        y: card.y - root.cornerRadius
                        width: panel.expanded ? card.width : root.edgeWidth
                        height: card.height + root.cornerRadius * 2
                    }

                    MouseArea {
                        id: hover

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: panel.hoveredLayout !== "" ? Qt.PointingHandCursor : Qt.ArrowCursor

                        // A click on a footer dot views that tag -- but not the tag
                        // already shown: with view_current_to_back set, mango takes
                        // that as a jump back to the previous tag. A click on a
                        // layout chip sets that layout on the current tag; on the
                        // current layout's own chip it does nothing.
                        onClicked: {
                            if (panel.previewing)
                                Quickshell.execDetached(["mmsg", "dispatch", "view," + panel.hoveredTag + ",0"]);
                            else if (panel.hoveredLayout !== "" && panel.hoveredLayout !== panel.currentLayout)
                                Quickshell.execDetached(["mmsg", "dispatch", "setlayout," + panel.hoveredLayout]);
                        }
                    }
                }
            }
        }
    }
}
