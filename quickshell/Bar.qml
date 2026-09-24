import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: root

	property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
	property alias start: start.data
	property alias middle: middle.data
	property alias end: end.data

	anchors { top: true; left: true; right: true }
	implicitHeight: 30
	color: monitor.activeWorkspace.toplevels.values.length > 0 ? "#50000000" : "transparent"

	Behavior on color {
		ColorAnimation { duration: 200 }
	}

	RowLayout {
		id: start
		spacing: 15
		anchors {
			left: parent.left
			verticalCenter: parent.verticalCenter
			leftMargin: 10
		}
	}

	RowLayout {
		id: middle
		spacing: 15
		anchors {
			centerIn: parent
		}
	}

	RowLayout {
		id: end
		spacing: 15
		anchors {
			right: parent.right
			verticalCenter: parent.verticalCenter
			rightMargin: 10
		}
	}
}
