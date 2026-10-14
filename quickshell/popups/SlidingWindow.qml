import QtQuick
import Quickshell

PanelWindow {
    id: root

    property string edge: "right"   // "left" | "right" | "top" | "bottom"
    property bool shown: false
    property int cardWidth: 320
    property int cardHeight: 140
    property int gap: 16            // distance between card and screen edge

    readonly property bool horiz: edge === "left" || edge === "right"

    // Single anchor -> layer-shell centers the surface on the other axis
    anchors {
        left:   edge === "left"
        right:  edge === "right"
        top:    edge === "top"
        bottom: edge === "bottom"
    }

    implicitWidth:  horiz ? cardWidth + gap : cardWidth
    implicitHeight: horiz ? cardHeight : cardHeight + gap

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore     // single anchor would otherwise reserve space
    visible: shown || card.progress > 0
    mask: Region { item: card }             // click-through everywhere except the card

    Rectangle {
        id: card
        width: root.cardWidth
        height: root.cardHeight
        radius: 12
        color: "#1e1e2e"

        property real progress: root.shown ? 1 : 0
        Behavior on progress {
            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
        }

        // Resting position (floating, `gap` from the edge) and off-screen position
        readonly property real restX: root.edge === "left" ? root.gap
                                    : root.edge === "right" ? root.width - width - root.gap
                                    : 0
        readonly property real offX:  root.edge === "left" ? -width
                                    : root.edge === "right" ? root.width
                                    : 0
        readonly property real restY: root.edge === "top" ? root.gap
                                    : root.edge === "bottom" ? root.height - height - root.gap
                                    : 0
        readonly property real offY:  root.edge === "top" ? -height
                                    : root.edge === "bottom" ? root.height
                                    : 0

        x: offX + (restX - offX) * progress
        y: offY + (restY - offY) * progress

        // your content here
    }
}
