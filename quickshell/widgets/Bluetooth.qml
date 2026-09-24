import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 5

	readonly property var adapter: Bluetooth.defaultAdapter

	Indicator {
		icon: "bluetooth"
		hideValue: true
	}
}
