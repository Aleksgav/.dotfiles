// Calendar — a drawer at the centre of the bottom screen edge, fully hidden
// until the pointer touches that edge, then sliding up to the full card. The
// card shows the current month; switches in its header show the months either
// side of it too, or the whole year. A pin keeps the drawer out.
//
// Run with:  qs -c calendar
//
// Styled like clocks/shell.qml and layout/shell.qml: the card is smoked glass
// over a light blur of whatever is behind it. The blur is mango's, not ours --
// a client cannot see past its own surface -- and mango/config.conf enables it
// for these widgets' layer namespaces only.

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

ShellRoot {
    id: root

    // Palette and fonts lifted from clocks/shell.qml, so the drawers match.
    // Duplicated rather than shared: each config runs as its own qs instance.
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
    readonly property color colDivider: "#33ffffff"    // white at 0.2 alpha: header/grid seam
    readonly property color colSheenTop: "#1affffff"   // white at 0.1 alpha
    readonly property color colSheenBottom: "#00ffffff"
    // Today's pill: the layout widget's current-chip fill, colAccent at 0.3.
    readonly property color colToday: "#4da3e0d6"
    // Fira Sans for text, the sans sibling of the FiraCode used across the
    // desktop; the Nerd Font only for the header icons, which Fira Sans lacks.
    readonly property string uiFont: "Fira Sans"
    readonly property string iconFont: "FiraCode Nerd Font"
    readonly property int uiSize: 13

    readonly property int padding: 16
    // Space above and below the month grids.
    readonly property int gridPadding: 12
    // One day of a month grid. A month is 7 of them across, and always 6
    // weeks down plus a weekday row -- 8 rows -- so every month is the same
    // size, however its days fall. A month title, where shown, is a 9th row.
    readonly property int cellWidth: 28
    readonly property int cellHeight: 22
    readonly property int monthWidth: cellWidth * 7
    readonly property int monthGap: padding
    // The year view: 4 months across, 3 down.
    readonly property int yearColumns: 4
    readonly property int yearRowGap: 8
    // Each view's width, and its height under the header. The card takes
    // the view's width, or the header's if that is wider (see panel).
    readonly property int monthViewWidth: monthWidth + padding * 2
    readonly property int threeViewWidth: monthWidth * 3 + monthGap * 2 + padding * 2
    readonly property int yearViewWidth: monthWidth * yearColumns + monthGap * (yearColumns - 1) + padding * 2
    readonly property int monthViewHeight: cellHeight * 7 + gridPadding * 2
    readonly property int threeViewHeight: cellHeight * 8 + gridPadding * 2
    readonly property int yearViewHeight: cellHeight * 8 * 3 + yearRowGap * 2 + gridPadding * 2
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

    // Written out rather than taken from the locale: Qt's QML engine has no
    // Intl, and the rest of the desktop's widgets are in English. Weeks start
    // on Monday.
    readonly property var monthNames: ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"]
    readonly property var dayNames: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

    SystemClock {
        id: clock
        // Hours: the widget only needs to notice the day change, which
        // falls on an hour.
        precision: SystemClock.Hours
    }

    readonly property int todayYear: clock.date.getFullYear()
    readonly property int todayMonth: clock.date.getMonth()   // 0-based, as in JS Date
    readonly property int todayDay: clock.date.getDate()

    // Month m of year y, carried into the year before or after when m runs
    // out of 0..11: shifted(2026, -1) is December 2025.
    function shifted(y, m) {
        const d = new Date(y, m, 1);
        return { year: d.getFullYear(), month: d.getMonth() };
    }

    function shortMonth(m) {
        return root.monthNames[m].slice(0, 3).toUpperCase();
    }

    // The header's title: what the view spans. "NOVEMBER 2026"; three months
    // as "OCT – DEC 2026", or "DEC 2026 – FEB 2027" across a new year; or
    // the year alone.
    function title(threeMonths, yearView) {
        if (yearView)
            return String(root.todayYear);
        if (!threeMonths)
            return root.monthNames[root.todayMonth].toUpperCase() + " " + root.todayYear;
        const first = shifted(root.todayYear, root.todayMonth - 1);
        const last = shifted(root.todayYear, root.todayMonth + 1);
        return first.year === last.year
            ? shortMonth(first.month) + " – " + shortMonth(last.month) + " " + last.year
            : shortMonth(first.month) + " " + first.year + " – " + shortMonth(last.month) + " " + last.year;
    }

    // Text without a shadow of its own, for the month grids, which cast one
    // shadow per month instead (see MonthGrid).
    component Glyph: Text {
        color: root.colFg
        font.family: root.uiFont
        font.pixelSize: root.uiSize
        verticalAlignment: Text.AlignVCenter
    }

    component Cell: Glyph {
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

    // Small dim capitals, like the clocks' table column titles: weekday
    // names and month titles.
    component ColumnTitle: Glyph {
        color: root.colDim
        font.pixelSize: root.uiSize - 4
        font.weight: Font.DemiBold
        font.letterSpacing: 1
        horizontalAlignment: Text.AlignHCenter
    }

    component Corner: PathArc {
        radiusX: root.cornerRadius
        radiusY: root.cornerRadius
    }

    // The card's silhouette, w x h: rounded outer corners, and at the screen
    // edge (the bottom) inverted corners that flare out to meet it, reaching
    // cornerRadius left and right. An open path, so the border traced along
    // it draws no line along the screen edge. Shared by the card's fill, its
    // border, and by the mask that keeps the shadow out from under the card.
    component CardOutline: ShapePath {
        id: outline

        property real w
        property real h

        strokeWidth: -1
        startX: -root.cornerRadius
        startY: outline.h

        Corner { x: 0; y: outline.h - root.cornerRadius; direction: PathArc.Counterclockwise }
        PathLine { x: 0; y: root.cornerRadius }
        Corner { x: root.cornerRadius; y: 0 }
        PathLine { x: outline.w - root.cornerRadius; y: 0 }
        Corner { x: outline.w; y: root.cornerRadius }
        PathLine { x: outline.w; y: outline.h - root.cornerRadius }
        Corner { x: outline.w + root.cornerRadius; y: outline.h; direction: PathArc.Counterclockwise }
    }

    // One month: an optional title, the weekday names, then six weeks of
    // days, Monday first. Days of the months either side are left blank.
    // Today sits on a pill in the accent colour.
    component MonthGrid: Item {
        id: grid

        property int year
        property int month
        property bool showTitle: false

        // Blank cells before the 1st: JS counts weekdays from Sunday.
        readonly property int lead: (new Date(grid.year, grid.month, 1).getDay() + 6) % 7
        // Day 0 of the next month is the last of this one.
        readonly property int length: new Date(grid.year, grid.month + 1, 0).getDate()
        readonly property bool isCurrent: grid.year === root.todayYear && grid.month === root.todayMonth
        // Today's cell, 0..41, or -1 in any other month.
        readonly property int todayCell: grid.isCurrent ? grid.lead + root.todayDay - 1 : -1

        width: root.monthWidth
        height: texts.height

        // Today's pill, under the numbers rather than in their shadow layer,
        // which would cast a shadow off its translucent fill too.
        Rectangle {
            visible: grid.todayCell >= 0
            x: (grid.todayCell % 7) * root.cellWidth + 2
            y: days.y + Math.floor(grid.todayCell / 7) * root.cellHeight + 1
            width: root.cellWidth - 4
            height: root.cellHeight - 2
            radius: 3
            color: root.colToday
            border.width: 1
            border.color: root.colAccent
        }

        Column {
            id: texts

            width: parent.width

            // The text shadow, as in Cell, but cast once for the whole month:
            // the year view holds over 500 numbers, and one layer each would
            // be over 500 offscreen textures and effect passes.
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: root.colTextShadow
                shadowBlur: 0
                blurMax: 2
                shadowHorizontalOffset: 1
                shadowVerticalOffset: 1
            }

            ColumnTitle {
                visible: grid.showTitle
                width: parent.width
                height: root.cellHeight
                text: root.monthNames[grid.month].toUpperCase()
                color: grid.isCurrent ? root.colAccent : root.colDim
            }

            Row {
                Repeater {
                    model: root.dayNames

                    ColumnTitle {
                        required property string modelData

                        width: root.cellWidth
                        height: root.cellHeight
                        text: modelData
                    }
                }
            }

            Grid {
                id: days

                columns: 7

                Repeater {
                    model: 42

                    Glyph {
                        id: day

                        required property int index
                        readonly property int number: day.index - grid.lead + 1

                        width: root.cellWidth
                        height: root.cellHeight
                        horizontalAlignment: Text.AlignHCenter
                        text: day.number >= 1 && day.number <= grid.length ? day.number : ""
                        // Saturday and Sunday a shade quieter.
                        color: day.index % 7 >= 5 && day.index !== grid.todayCell ? root.colDim : root.colFg
                        // Tabular digits, so the columns line up.
                        font.features: { "tnum": 1 }
                    }
                }
            }
        }
    }

    // One drawer per connected screen. Besides putting the widget on every
    // monitor, this is what makes it survive a disconnect/reconnect cycle --
    // without it the window may simply not come back when an output returns.
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
            //
            // All three ignore the bottom waybar's exclusive zone, so they sit
            // on the screen edge itself, and are on the overlay layer, so the
            // open card covers the middle of that bar instead of going under
            // it (on the top layer, with waybar, which of the two is on top
            // would depend on which started last). The overlay layer is also
            // above fullscreen windows, so the edge strip opens the drawer
            // over them too.
            Scope {
                id: perScreen

                // The screen from Quickshell.screens is injected here.
                required property var modelData

                // Draws the shadow surface once more, a moment after the card
                // changes size (a view switch). Its frame for the change itself
                // can go missing -- seen under mango with the clocks: the
                // shadows and their tint stay at the old view's size -- and
                // nothing else redraws the surface while the drawer stands
                // still. Toggling updatesEnabled is the redraw Quickshell offers.
                Timer {
                    id: shadowRedraw

                    interval: 100
                    onTriggered: {
                        shadowSurface.updatesEnabled = false;
                        shadowSurface.updatesEnabled = true;
                    }
                }

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
                    id: shadowSurface

                    screen: perScreen.modelData
                    visible: panel.visible

                    WlrLayershell.layer: WlrLayer.Overlay

                    anchors {
                        bottom: true
                    }

                    exclusionMode: ExclusionMode.Ignore
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
                            x: -root.shadowSize - root.cornerRadius
                            y: -root.shadowSize
                            width: card.width + (root.shadowSize + root.cornerRadius) * 2
                            height: card.height + root.shadowSize

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
                                x: root.shadowSize + root.cornerRadius
                                y: root.shadowSize
                                width: card.width
                                height: card.height
                                radius: root.cornerRadius
                                bottomLeftRadius: 0
                                bottomRightRadius: 0
                                blur: root.shadowBlur
                                offset.y: root.shadowDrop
                                color: "#73000000" // black at 0.45 alpha
                            }

                            RectangularShadow {
                                x: root.shadowSize + root.cornerRadius
                                y: root.shadowSize
                                width: card.width
                                height: card.height
                                radius: root.cornerRadius
                                bottomLeftRadius: 0
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

                            x: -root.shadowSize - root.cornerRadius
                            y: -root.shadowSize
                            width: card.width + (root.shadowSize + root.cornerRadius) * 2
                            height: card.height + root.shadowSize
                            visible: false
                            layer.enabled: true

                            Shape {
                                x: root.shadowSize + root.cornerRadius
                                y: root.shadowSize
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
                    WlrLayershell.namespace: "quickshell-calendar"
                    WlrLayershell.layer: WlrLayer.Overlay

                    // Anchored to the bottom edge only, so the layer-shell
                    // protocol centers it horizontally on that edge.
                    anchors {
                        bottom: true
                    }

                    // On the screen edge itself, not above the bottom waybar's
                    // exclusive zone (see the Scope above). Reserves no space.
                    exclusionMode: ExclusionMode.Ignore

                    color: "transparent"

                    // The surface is always sized for the expanded card in its
                    // largest view, the year, and never moves or resizes; the card
                    // slides inside it instead, so hovering costs no compositor
                    // round-trip per animation frame. The extra size is room for
                    // the inverted corners left and right of the card, and for its
                    // shadow on every side but the screen edge, which the shadow
                    // surface (declared before this one) draws into this footprint.
                    implicitWidth: Math.max(root.yearViewWidth, panel.headerWidth)
                        + (root.shadowSize + root.cornerRadius) * 2
                    implicitHeight: header.height + Math.max(root.monthViewHeight, root.threeViewHeight, root.yearViewHeight)
                        + root.shadowSize

                    // Toggled by the header's pin: a pinned drawer stays out after
                    // the pointer leaves. Per panel, so each screen pins on its own.
                    property bool pinned: false
                    readonly property bool expanded: hover.containsMouse || panel.pinned

                    // Toggled by the header's switches: the months either side
                    // of this one too, or the whole year. The year shows in
                    // place of whichever of the other two threeMonths picks.
                    // Per panel, like pinned.
                    property bool threeMonths: false
                    property bool yearView: false
                    // True only while the view changes. The card changes size
                    // then, and its y with it, which must jump to place rather
                    // than slide like the drawer.
                    property bool switchingView: false

                    // The width the header needs: its icons, the title, and
                    // the gap between them (the year icon's right padding). A
                    // month alone is narrower than "SEPTEMBER 2026" beside
                    // three icons, so the card widens to fit. Rounded up to a
                    // whole pixel, so the centred card's edges stay sharp.
                    readonly property int headerWidth: Math.ceil(pinIcon.implicitWidth + threeIcon.implicitWidth
                        + yearIcon.implicitWidth + headerText.implicitWidth + root.padding)

                    // The pointer, as the hit surface sees it, in card coordinates.
                    // The surfaces lie exactly over each other, so its window
                    // coordinates are this window's too.
                    readonly property point pointer: Qt.point(hover.mouseX - card.x, hover.mouseY - card.y)
                    readonly property bool pinHovered: hover.containsMouse
                        && pinIcon.contains(pinIcon.mapFromItem(card, panel.pointer))
                    readonly property bool threeHovered: hover.containsMouse
                        && threeIcon.contains(threeIcon.mapFromItem(card, panel.pointer))
                    readonly property bool yearHovered: hover.containsMouse
                        && yearIcon.contains(yearIcon.mapFromItem(card, panel.pointer))

                    // Empty: all input goes to the hit surface (see the Scope above).
                    mask: Region {}

                    Item {
                        id: card

                        // Centred on the surface, like the surface on the screen
                        // edge. Out, the card meets the bottom of the surface.
                        // Closed, the whole card is past that edge and clipped
                        // away -- far enough that its shadow's blur goes too;
                        // only the hit surface's edge strip remains, invisible
                        // but hoverable.
                        x: Math.round((panel.width - card.width) / 2)
                        y: panel.expanded ? panel.height - card.height : panel.height + root.shadowBlur
                        width: Math.max(panel.yearView ? root.yearViewWidth
                            : panel.threeMonths ? root.threeViewWidth
                            : root.monthViewWidth, panel.headerWidth)
                        height: header.height + (panel.yearView ? root.yearViewHeight
                            : panel.threeMonths ? root.threeViewHeight
                            : root.monthViewHeight)

                        onWidthChanged: shadowRedraw.restart()
                        onHeightChanged: shadowRedraw.restart()

                        Behavior on y {
                            enabled: !panel.switchingView

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
                        }

                        Column {
                            id: content

                            width: parent.width
                            spacing: 0

                            // Header strip: spans the full card width so the lighter
                            // fill reads as a title bar rather than a floating patch.
                            Rectangle {
                                id: header

                                width: parent.width
                                height: headerText.implicitHeight + 14
                                // Rounded where it meets the card's own corners,
                                // which it would otherwise poke past.
                                topLeftRadius: root.cornerRadius
                                topRightRadius: root.cornerRadius
                                color: root.colHeaderBg

                                // Pin toggle: outline while unpinned, filled in
                                // the accent colour while pinned. Padded rather
                                // than offset, so the whole padded box, at the
                                // full header height, takes the click (on the
                                // hit surface, through panel.pinHovered). The
                                // gap to the next icon is split between the two
                                // boxes.
                                Cell {
                                    id: pinIcon

                                    anchors.left: parent.left
                                    height: parent.height
                                    leftPadding: root.padding
                                    rightPadding: root.padding / 2

                                    text: panel.pinned ? "󰐃" : "󰤱"
                                    font.family: root.iconFont
                                    color: panel.pinned || panel.pinHovered ? root.colAccent : root.colDim
                                }

                                // Three-months switch: outline while off, filled
                                // in the accent colour while on, like the pin.
                                // From the year view, a click shows the three
                                // months. Padded and clicked like the pin
                                // (panel.threeHovered).
                                Cell {
                                    id: threeIcon

                                    readonly property bool on: panel.threeMonths && !panel.yearView

                                    anchors.left: pinIcon.right
                                    height: parent.height
                                    leftPadding: root.padding / 2
                                    rightPadding: root.padding / 2

                                    text: threeIcon.on ? "󰙹" : "󰭨"
                                    font.family: root.iconFont
                                    color: threeIcon.on || panel.threeHovered ? root.colAccent : root.colDim
                                }

                                // Year switch: outline while off, filled in the
                                // accent colour while on. Padded and clicked
                                // like the others (panel.yearHovered).
                                Cell {
                                    id: yearIcon

                                    anchors.left: threeIcon.right
                                    height: parent.height
                                    leftPadding: root.padding / 2
                                    rightPadding: root.padding

                                    text: panel.yearView ? "󰃱" : "󱁳"
                                    font.family: root.iconFont
                                    color: panel.yearView || panel.yearHovered ? root.colAccent : root.colDim
                                }

                                Cell {
                                    id: headerText

                                    anchors.right: parent.right
                                    anchors.rightMargin: root.padding
                                    anchors.verticalCenter: parent.verticalCenter

                                    text: root.title(panel.threeMonths, panel.yearView)
                                    font.pixelSize: (root.uiSize - 3) * 1.5
                                    font.weight: Font.Black
                                    font.italic: true
                                    font.letterSpacing: 1.5
                                }

                                // Hairline seam between the header and the grid.
                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    width: parent.width
                                    height: 1
                                    color: root.colDivider
                                }
                            }

                            // The month view: this month alone. Its name is in
                            // the header.
                            Item {
                                visible: !panel.threeMonths && !panel.yearView
                                width: parent.width
                                height: root.monthViewHeight

                                MonthGrid {
                                    x: Math.round((parent.width - width) / 2)
                                    y: root.gridPadding
                                    year: root.todayYear
                                    month: root.todayMonth
                                }
                            }

                            // The three-months view: last month, this one and
                            // the next, side by side.
                            Item {
                                visible: panel.threeMonths && !panel.yearView
                                width: parent.width
                                height: root.threeViewHeight

                                Row {
                                    x: Math.round((parent.width - width) / 2)
                                    y: root.gridPadding
                                    spacing: root.monthGap

                                    Repeater {
                                        model: [-1, 0, 1]

                                        MonthGrid {
                                            required property int modelData

                                            year: root.shifted(root.todayYear, root.todayMonth + modelData).year
                                            month: root.shifted(root.todayYear, root.todayMonth + modelData).month
                                            showTitle: true
                                        }
                                    }
                                }
                            }

                            // The year view: all twelve months of this year.
                            Item {
                                visible: panel.yearView
                                width: parent.width
                                height: root.yearViewHeight

                                Grid {
                                    x: Math.round((parent.width - width) / 2)
                                    y: root.gridPadding
                                    columns: root.yearColumns
                                    columnSpacing: root.monthGap
                                    rowSpacing: root.yearRowGap

                                    Repeater {
                                        model: 12

                                        MonthGrid {
                                            required property int index

                                            year: root.todayYear
                                            month: index
                                            showTitle: true
                                        }
                                    }
                                }
                            }
                        }

                        // The card's border: a line traced along its outline,
                        // over the header and grid. The outline is an open path,
                        // so no line is drawn along the screen edge; it runs out
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

                    WlrLayershell.layer: WlrLayer.Overlay

                    anchors {
                        bottom: true
                    }

                    exclusionMode: ExclusionMode.Ignore
                    color: "transparent"
                    implicitWidth: panel.implicitWidth
                    implicitHeight: panel.implicitHeight

                    // Only the card's footprint takes input; clicks on the
                    // transparent rest fall through to the windows underneath.
                    // Closed, that is a thin strip along the screen edge, as wide
                    // as the card, so pushing the pointer against the middle of
                    // the edge opens the drawer. Bound to the target state rather
                    // than to the animating card, so the hit area does not shrink
                    // mid-slide. The shadow margin is left out, so the shadow
                    // takes no clicks; the inverted corners either side of the
                    // card are in.
                    mask: Region {
                        x: panel.expanded ? card.x - root.cornerRadius : card.x
                        y: panel.expanded ? hitSurface.height - card.height : hitSurface.height - root.edgeWidth
                        width: panel.expanded ? card.width + root.cornerRadius * 2 : card.width
                        height: panel.expanded ? card.height : root.edgeWidth
                    }

                    MouseArea {
                        id: hover

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: panel.pinHovered || panel.threeHovered || panel.yearHovered
                            ? Qt.PointingHandCursor : Qt.ArrowCursor

                        onClicked: {
                            if (panel.pinHovered) {
                                panel.pinned = !panel.pinned;
                            } else if (panel.threeHovered) {
                                panel.switchingView = true;
                                panel.threeMonths = panel.yearView || !panel.threeMonths;
                                panel.yearView = false;
                                panel.switchingView = false;
                            } else if (panel.yearHovered) {
                                panel.switchingView = true;
                                panel.yearView = !panel.yearView;
                                panel.switchingView = false;
                            }
                        }
                    }
                }
            }
        }
    }
}
