import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
	id: root
	required property HyprlandMonitor monitor
	required property list<HyprlandWorkspace> workspaces

	Rectangle {
	anchors.verticalCenter: parent.verticalCenter
	width: 20
	height: 20
	radius: width / 2
	color: "transparent"
	border.color: "#c0caf5"
	border.width: 1.5
	x: root.workspaces.findIndex(ws => ws.id === root.monitor.activeWorkspace.id) * 25

	Behavior on x {
		NumberAnimation { duration: 100 }
	}
	}

	RowLayout {
	spacing: 30
	anchors.verticalCenter: parent.verticalCenter

	Repeater {
		model: root.workspaces

		Rectangle {
		id: ws
		required property var modelData
		property bool active: modelData.active
		property bool occupied: modelData.toplevels.values.length > 0

		anchors.verticalCenter: parent.verticalCenter
		width: 10
		height: width
		radius: width / 2

		color: "#c0caf5"

		Behavior on width {
			NumberAnimation { duration: 200 }
		}
		}
	}
	}
}
