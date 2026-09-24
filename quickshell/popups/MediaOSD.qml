import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

OSD {
	id: root

	property MprisPlayer player: Mpris.players.values[0]

	Connections {
		target: root.player
		function onPlaybackStateChanged() {
			const isPlaying = root.player?.playbackState === MprisPlaybackState.Playing
			if (isPlaying)
				root.open()
			else
				root.close()
		}
	}

	content: RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30
		spacing: 10

		Image {
			source: root.player.trackArtUrl
			sourceSize: Qt.size(48, 48)
		}

		ColumnLayout {
			Text {
				Layout.fillWidth: true
				elide: Text.ElideRight
				text: root.player.trackTitle
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
				text: root.player.trackArtist
				font {
					family: "Inter"
					pixelSize: 14
				}
				color: "white"
			}
		}
	}
}
