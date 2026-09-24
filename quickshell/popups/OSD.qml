pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

BasePopup {
	id: root
	window: PanelWindow {
		WlrLayershell.namespace: "quickshell.osd"
		anchors.bottom: true
		margins.bottom: screen.height / 5
		implicitWidth: 300
		implicitHeight: 80
		color: "transparent"
		exclusiveZone: 0

		Rectangle {
			id: pane
			anchors.fill: parent
			radius: height / 2
			color: "#80000000"

			Loader {
				anchors.fill: parent
				sourceComponent: root.content
			}
		}
	}

	required property Component content
}
