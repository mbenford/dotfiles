import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.workspaces

Item {
	id: root
	required property ShellScreen screen
	property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
	property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
		.filter(ws => ws.id > 0)
		.filter(ws => ws.monitor === monitor)

	Dots {
		monitor: root.monitor
		workspaces: root.workspaces
	}
}
