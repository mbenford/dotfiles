//@ pragma IconTheme Papirus

import Quickshell
import QtQuick
import qs.services as Services
import qs.widgets as Widgets
import qs.popups as Popups

ShellRoot {
	Connections {
		target: Quickshell
		function onReloadCompleted() {
			Quickshell.inhibitReloadPopup()
		}
	}

	Variants {
		model: Quickshell.screens

		Bar {
			required property var modelData
			id: bar
			screen: modelData

			start: [
				Widgets.Workspaces { screen: bar.screen },
			]
			middle: [
				Widgets.Clock {},
			]
			end: [
				Widgets.System {},
				Widgets.Network {},
				Widgets.Bluetooth {},
				Widgets.Audio { nodeType: Services.Audio.NodeType.Sink },
				Widgets.Audio { nodeType: Services.Audio.NodeType.Source },
				Widgets.Battery {},
			]
		}
	}
	Popups.VolumeOSD {}
	Popups.MediaOSD {}
	Popups.Notification {}
}
