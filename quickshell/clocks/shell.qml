// World clocks — a decorationless panel pinned to the wallpaper, below windows.
//
// Run with:  qs -c clocks
//
// All timezone handling lives in scripts/clocks.sh, not here: Qt 6's QML engine
// ships no Intl implementation and exposes no QTimeZone binding, so
// Qt.formatDateTime() can only render local time. This file just renders rows.

import Quickshell
import Quickshell.Io
import QtQuick

ShellRoot {
    id: root

    // Rows produced by scripts/clocks.sh. To add or remove a city, edit that
    // script's ZONES list -- nothing in this file needs to change.
    property var zones: []

    // Palette and font lifted from waybar/style.css so the widget reads as part
    // of the same desktop rather than a stranger on it.
    readonly property color colFg: "#c5c8c6"
    readonly property color colDim: "#707880"
    readonly property color colAccent: "#8abeb7"
    readonly property color colBg: "#aa282a2e"       // #282a2e at ~0.667 alpha
    readonly property color colHeaderBg: "#cc0d0e10" // waybar's "much darker" tone
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

    component Cell: Text {
        color: root.colFg
        font.family: root.uiFont
        font.pixelSize: root.uiSize
        verticalAlignment: Text.AlignVCenter
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

                anchors {
                    top: true
                    right: true
                }

                margins {
                    top: 12
                    right: 12
                }

                // Sit on the wallpaper, below normal windows.
                aboveWindows: false

                // exclusionMode is deliberately left at its ExclusionMode.Auto
                // default: Auto only reserves space when exactly 3 anchors are
                // connected, and this panel has 2, so it reserves nothing while
                // still respecting waybar's exclusion zone -- which is what keeps
                // it clear of the top bar.

                color: "transparent"

                implicitWidth: card.width
                implicitHeight: card.height

                Rectangle {
                    id: card

                    width: root.rowWidth + root.padding * 2
                    height: content.implicitHeight
                    radius: 2
                    color: root.colBg

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
                            radius: 2
                            color: root.colHeaderBg

                            Cell {
                                id: headerText

                                anchors.right: parent.right
                                anchors.rightMargin: root.padding
                                anchors.verticalCenter: parent.verticalCenter

                                text: "WORLD CLOCKS"
                                color: root.colDim
                                font.pixelSize: root.uiSize - 2
                            }
                        }

                        Column {
                            id: rows

                            width: parent.width
                            spacing: 4
                            topPadding: 10
                            bottomPadding: 10
                            leftPadding: root.padding
                            rightPadding: root.padding

                            Repeater {
                                model: root.zones

                                Row {
                                    id: clockRow

                                    required property var modelData

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
