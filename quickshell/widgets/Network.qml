import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 5

	property var device: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
	property var active: device?.networks.values.find(n => n.connected)
	readonly property real signal: active ? active.signalStrength : 0

	Indicator {
	icons: ["wifi-0", "wifi-1", "wifi-2", "wifi-3", "wifi-4"]
	value: root.signal
	hideValue: true
	}
}
