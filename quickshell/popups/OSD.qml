pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.settings as Settings

Item {
	id: root
	implicitWidth: 300
	implicitHeight: 80

	required property Component content
	property int interval: Settings.OSD.timeout

	LazyLoader {
		id: loader
		active: isVisible()

		PanelWindow {
			WlrLayershell.namespace: "quickshell.osd"
			anchors.bottom: true
			margins.bottom: screen.height / 5
			implicitWidth: root.implicitWidth
			implicitHeight: root.implicitHeight
			color: "transparent"
			exclusiveZone: 0

			Rectangle {
				id: pane
				anchors.fill: parent
				radius: height / 2
				color: Settings.OSD.backgroundColor

				Loader {
					anchors.fill: parent
					sourceComponent: root.content
				}
			}
		}
	}

	function show(): void {
		OSDManager.enter(root)
	}
	function hide(): void {
		OSDManager.release(root)
	}
	function isVisible(): bool {
		return OSDManager.active === root
	}
}
