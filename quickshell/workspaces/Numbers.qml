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
	color: "grey"
	radius: 5
	x: root.workspaces.findIndex(ws => ws.id === root.monitor.activeWorkspace.id) * 25

	Behavior on x {
		NumberAnimation { duration: 100 }
	}
	}

	RowLayout {
	spacing: 5
	anchors.verticalCenter: parent.verticalCenter

	Repeater {
		model: root.workspaces

		Rectangle {
		width: 20
		height: 20
		color: "transparent"

		Text {
			text: {
			const id = parseInt(root.workspaces[index].id, 10)
			return id < 10 ? id : 0
			}
			font.family: "Inter"
			color: "white"
			anchors.centerIn: parent
		}
		}
	}
	}
}
