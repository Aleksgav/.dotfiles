// Window-layout minimap — a drawer on the left screen edge, fully hidden until
// the pointer touches that edge, then sliding out to a scaled-down map of the
// windows on the monitor's current tag.
//
// Run with:  qs -c layout
//
// Everything shown comes from mango's IPC (mmsg). Its `watch` streams print the
// full current state once on start, then again on every change.

import Quickshell
import Quickshell.Io
import QtQuick
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

    // Palette and font lifted from waybar/style.css, same as clocks/shell.qml.
    // Duplicated rather than shared: the two configs run as separate qs instances.
    readonly property color colFg: "#c5c8c6"
    // colDim and colBg depart from waybar: at waybar's ~0.667 alpha, a light
    // window behind the card blended it to ~#707174, the same grey as waybar's
    // #707880 dim text, which made that text vanish.
    readonly property color colDim: "#969896"
    readonly property color colAccent: "#8abeb7"
    readonly property color colBg: "#ee282a2e"       // #282a2e at ~0.933 alpha
    readonly property color colHeaderBg: "#cc0d0e10" // waybar's "much darker" tone
    readonly property color colWin: "#373b41"
    readonly property color colWinFocused: "#448abeb7" // colAccent at ~0.267 alpha
    readonly property string uiFont: "FiraCode Nerd Font"
    readonly property int uiSize: 13

    readonly property int mapWidth: 280
    readonly property int padding: 12
    // Invisible strip along the screen edge that still takes hover while the
    // drawer is closed, so pushing the pointer against the edge opens it.
    readonly property int edgeWidth: 2
    // Radius of the card's rounded outer corners, and of the inverted corners
    // that join it to the screen edge.
    readonly property int cornerRadius: 8

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
            PanelWindow {
                id: panel

                // The screen from Quickshell.screens is injected here.
                required property var modelData

                screen: panel.modelData

                // This screen's entry in mango's monitor list, matched by output
                // name ("HDMI-A-1"). Hidden until it is found.
                readonly property var mon: root.monitors.find(m => m.name === panel.modelData.name) || null
                readonly property real scale: panel.mon ? root.mapWidth / panel.mon.width : 0
                readonly property int monX: panel.mon ? panel.mon.x : 0
                readonly property int monY: panel.mon ? panel.mon.y : 0

                // Windows shown on this monitor right now; floating ones last so
                // they draw on top of the tiled ones, as on screen.
                readonly property var windows: panel.mon
                    ? root.clients
                        .filter(c => c.monitor === panel.mon.name && c.is_visible && !c.is_minimized)
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
                // no compositor round-trip per animation frame. The extra height is
                // room for the inverted corners above and below the card.
                implicitWidth: card.width
                implicitHeight: card.height + root.cornerRadius * 2

                readonly property bool expanded: hover.containsMouse

                // Only the visible part takes input; clicks on the transparent rest
                // fall through to the windows underneath. Bound to the target state
                // rather than to the animating card, so the hit area does not shrink
                // mid-slide.
                mask: Region {
                    x: 0
                    width: panel.expanded ? panel.width : root.edgeWidth
                    height: panel.height
                }

                MouseArea {
                    id: hover

                    anchors.fill: parent
                    hoverEnabled: true

                    Item {
                        id: card

                        // Closed, the whole card is past the left edge of the
                        // surface and clipped away; only the mask's edge strip
                        // remains, invisible but hoverable.
                        x: panel.expanded ? 0 : -width
                        y: root.cornerRadius
                        width: content.width
                        height: content.implicitHeight

                        Behavior on x {
                            NumberAnimation {
                                duration: 180
                                easing.type: Easing.OutCubic
                            }
                        }

                        // The card's fill: rounded outer corners, and at the screen
                        // edge inverted corners that flare out to meet it. Drawn as
                        // one path, not a Rectangle plus corner pieces: translucent
                        // pieces abutting at a fractional device pixel (the screen is
                        // at 1.5x) would leave a visible seam between them.
                        Shape {
                            anchors.fill: parent
                            preferredRendererType: Shape.CurveRenderer // antialiased arcs

                            ShapePath {
                                fillColor: root.colBg
                                strokeWidth: -1

                                startX: 0
                                startY: -root.cornerRadius

                                Corner { x: root.cornerRadius; y: 0; direction: PathArc.Counterclockwise }
                                PathLine { x: card.width - root.cornerRadius; y: 0 }
                                Corner { x: card.width; y: root.cornerRadius }
                                PathLine { x: card.width; y: card.height - root.cornerRadius }
                                Corner { x: card.width - root.cornerRadius; y: card.height }
                                PathLine { x: root.cornerRadius; y: card.height }
                                Corner { x: 0; y: card.height + root.cornerRadius; direction: PathArc.Counterclockwise }
                            }

                            // The top inverted corner sits beside the header, so it
                            // also takes the header's darker fill on top.
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
                                height: layoutText.implicitHeight + 10
                                // Square except the corner it shares with the
                                // card, which would otherwise poke past the card's.
                                topRightRadius: root.cornerRadius
                                color: root.colHeaderBg

                                Cell {
                                    id: layoutText

                                    anchors.left: parent.left
                                    anchors.leftMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    // "tile" -> "[Tile]"
                                    text: {
                                        if (!panel.mon)
                                            return "";
                                        const name = root.layoutNames[panel.mon.layout_symbol] || panel.mon.layout_symbol;
                                        return "[" + name.charAt(0).toUpperCase() + name.slice(1) + "]";
                                    }
                                    color: root.colAccent
                                    font.pixelSize: root.uiSize - 2
                                    font.bold: true
                                    // FiraCode ships no italic, so Qt slants it.
                                    font.italic: true
                                }

                                Cell {
                                    anchors.right: parent.right
                                    anchors.rightMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    text: panel.mon ? panel.mon.active_tags.map(t => root.tagNames[t] || t).join("  ") : ""
                                    color: root.colDim
                                    font.pixelSize: root.uiSize - 2
                                }
                            }

                            Item {
                                width: parent.width
                                height: map.height + root.padding * 2

                                // The monitor, scaled down to mapWidth.
                                Rectangle {
                                    id: map

                                    x: root.padding
                                    y: root.padding
                                    width: root.mapWidth
                                    height: panel.mon ? Math.round(panel.mon.height * panel.scale) : 0
                                    color: root.colHeaderBg

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
                                            border.color: win.modelData.is_focused ? root.colAccent : root.colDim
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
                        }
                    }
                }
            }
        }
    }
}
