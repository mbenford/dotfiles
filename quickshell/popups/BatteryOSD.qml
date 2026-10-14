pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.util

OSD {
	id: root
	property var battery: UPower.displayDevice

	Connections {
		target: root.battery
		function onStateChanged(): void{
			if (root.battery.state === UPowerDeviceState.Charging || root.battery.state === UPowerDeviceState.Discharging) {
				root.show()
			}
		}
	}

	content: RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30
		spacing: 10

		Icon {
			name: "battery-7"
			size: 48
		}
		ColumnLayout {
			Text {
				Layout.fillWidth: true
				elide: Text.ElideRight
				text: root.battery.state === UPowerDeviceState.Charging ? "Charging" : "Discharging"
				font {
					family: "Inter"
					pixelSize: 16
					bold: true
				}
				color: "white"
			}
			Text {
				Layout.fillWidth: true
				elide: Text.ElideRight
				text: {
					if (root.battery.state === UPowerDeviceState.Charging) {
						return `Time to full: ${Fmt.duration(root.battery.timeToFull, { compact: true, seconds: false })}`
					}
					if (root.battery.state === UPowerDeviceState.Discharging) {
						return `Time to empty: ${Fmt.duration(root.battery.timeToEmpty, { compact: true, seconds: false })}`
					}
				}
				font {
					family: "Inter"
					pixelSize: 14
				}
				color: "white"
			}
		}
	}
}
