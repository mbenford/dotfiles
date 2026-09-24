import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 5
	anchors.verticalCenter: parent.verticalCenter

	required property HyprlandMonitor monitor
	required property list<HyprlandWorkspace> workspaces

	Repeater {
		model: root.workspaces

		Item {
			id: ws
			required property var modelData
			property bool active: modelData.active
			property bool occupied: modelData.toplevels.values.length > 0
			property bool urgent: modelData.urgent

			implicitWidth: circle.width
			implicitHeight: circle.height

			Rectangle {
				id: circle
				anchors.centerIn: parent
				width: 16
				height: width
				radius: width / 2

				color: "transparent"
				border.color: "#c0caf5"
				border.width: 1.5
			}

			Rectangle {
				anchors.centerIn: parent
				width: {
					if (ws.active) return 16
					if (ws.occupied) return 6
					return 0
				}
				height: width
				radius: width / 2

				color: {
					if (ws.urgent) return "red"
					return "#c0caf5"
				}

				Behavior on width {
					NumberAnimation { duration: 200 }
				}
			}
		}
	}
}
