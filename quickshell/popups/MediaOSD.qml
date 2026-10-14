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
	property MprisPlayer player: null
	property var track: ({})

	function updateTrack(player: MprisPlayer): void {
		root.track = {
			title: player.trackTitle,
			artist: player.trackArtist,
		}
	}

	Connections {
		target: Media
		function onMediaAction(action: string, player: MprisPlayer, value: var): void {
			root.player = player
			if (root.player === null) {
				settler.stop()
				root.action = ""
				root.track = ({})
				root.show()
				return
			}

			switch (action) {
				case "playpause":
					root.action = root.player.isPlaying ? "pause" : "play"
					break;
				case "seek":
					root.action = Number(value) > 0 ? "skip" : "replay"
					break;
				default:
					root.action = action
					break
			}

			if (root.action == "prev" || root.action == "next") {
				settler.start(root.player)
				return
			}

			settler.stop()
			root.updateTrack(root.player)
			root.show()
		}
	}

	Connections {
		id: settler
		target: root.player
		enabled: false
		property string previousTrackID: ""

		function start(player: MprisPlayer): void {
			previousTrackID = fingerprint(player)
			enabled = true

			if (root.isVisible()) root.show()
		}

		function stop(): void {
			enabled = false
		}

		function changed(prop: string): void {
			const id = fingerprint(target)
			if (id === "") return

			const settled = prop !== "position"
				? id !== previousTrackID
				: id === previousTrackID && target.position < 2

			if (settled) {
				enabled = false
				root.action = "play"
				root.updateTrack(root.player)
				root.show()
				artTimer.restart()
			}
		}

		function fingerprint(player: MprisPlayer): string {
			if (player.trackTitle === "" || player.trackArtist === "") return ""
			return `${player.trackTitle}:${player.trackArtist}`
		}

		function onTrackTitleChanged(): void { changed("title") }
		function onTrackArtistChanged(): void { changed("artist") }
		function onPositionChanged(): void { changed("position"); }
	}

	Timer {
		id: artTimer
		interval: 500
		onTriggered: {
			artImage.source = root.player?.trackArtUrl ?? ""
		}
	}
	Image {
		id: artImage
		visible: false
		sourceSize.width: 48
	}

	content: RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30
		spacing: 10

		Icon {
			name: "media-album"
			size: 48
			visible: artTimer.running
		}
		Image {
			source: root.action === "play" || root.action === "pause" ? root.player?.trackArtUrl : artImage.source
			sourceSize.width: 48
			visible: !artTimer.running
		}
		ColumnLayout {
			Text {
				Layout.fillWidth: true
				elide: Text.ElideRight
				text: root.player ? root.track.title : "Nothing to play"
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
				text: root.player ? root.track.artist : "No player is available"
				font {
					family: "Inter"
					pixelSize: 14
				}
				color: "white"
			}
		}
		Icon {
			name: {
				if (root.player === null) return "media-no-player"
				if (root.player.isPlaying) return "media-play"
				if (settler.enabled) return "media-pause"
				return "media-" + root.action
			}
			size: 48
		}
	}
}
