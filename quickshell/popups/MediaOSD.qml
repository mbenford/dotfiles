pragma ComponentBehavior: Bound

import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

OSD {
	id: root
	implicitWidth: 350
	interval: 2000

	property string action: ""
	property var actionValue: ""

	Connections {
		target: Media
		function onActionRequested(player: MprisPlayer, action: string, value: var): void {
			root.action = player === null ? "" : action
			root.actionValue = player === null ? null : value
			root.show()
		}
	}


	content: RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30
		spacing: 10

		Icon {
			name: "media-album"
			size: 48
			visible: Media.currentTrack.art === ""
		}
		Image {
			source: Media.currentTrack.art
			sourceSize.width: 48
			visible: Media.currentTrack.art !== ""
		}
		ColumnLayout {
			Text {
				Layout.fillWidth: true
				elide: Text.ElideRight
				text: Media.currentTrack.title || "Nothing to play"
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
				text: Media.currentTrack.artist || "No player is available"
				font {
					family: "Inter"
					pixelSize: 14
				}
				color: "white"
			}
		}
		Icon {
			name: {
				switch (root.action) {
					case "playpause":
						return Media.activePlayer.isPlaying ? "media-pause" : "media-play"
					case "seek":
						return Number(root.actionValue) > 0 ? "media-skip" : "media-replay"
					case "prev":
					case "next":
						return Media.activePlayer.isPlaying ? "media-play" : `media-${action}`
					default:
						return ""
				}
			}
			size: 48
		}
	}
}
