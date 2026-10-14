import Quickshell.Widgets
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts

WrapperItem {
	id: root

	property var device: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
	property var active: device?.networks.values.find(n => n.connected)
	readonly property real signal: active ? active.signalStrength : 0

	Indicator {
		icons: ["wifi-0", "wifi-1", "wifi-2", "wifi-3", "wifi-4"]
		// icons: ["signal_wifi_statusbar_null", "network_wifi_1_bar", "network_wifi_2_bar", "network_wifi_3_bar", "signal_wifi_4_bar"]
		value: root.signal
		hideValue: true
	}
}
