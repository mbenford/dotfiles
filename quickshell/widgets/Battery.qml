import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 5

	property var battery: UPower.displayDevice

	Indicator {
	icons: ["battery-0", "battery-1", "battery-2", "battery-3", "battery-4", "battery-5", "battery-6", "battery-7"]
	value: root.battery.percentage
	hideValue: true
	}
}
