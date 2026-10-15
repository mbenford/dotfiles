pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Singleton {
	id: root

	readonly property MprisPlayer activePlayer: {
		return Mpris.players.values.find(p => p.isPlaying)
			?? Mpris.players.values[0]
			?? null
	}

	readonly property QtObject currentTrack: QtObject {
		property string title: ""
		property string artist: ""
		property string art: ""
	}

	signal actionRequested(player: MprisPlayer, action: string, value: var)

	function play(): bool {
		return run("play", false, p => p.canPlay, p => p.play())
	}
	function pause(): bool {
		return run("pause", false, p => p.canPause, p => p.pause())
	}
	function playpause(): bool {
		return run("playpause", false, p => p.canTogglePlaying, p => p.togglePlaying())
	}
	function stop(): bool {
		return run("stop", false, p => p.canControl, p => p.stop())
	}
	function next(): bool {
		return run("next", true, p => p.canGoNext, p => p.next())
	}
	function previous(): bool {
		return run("prev", true, p => p.canGoPrevious, p => p.previous())
	}
	function seek(offset: int): bool {
		return run("seek", false, p => p.canSeek, p => p.seek(offset), offset)
	}
	function setPosition(seconds: int): bool {
		return run("position", false, p => p.canSeek && p.positionSupported, p => { p.position = seconds }, seconds)
	}

	function run(action: string, isAsync: bool, canExecute: var, operation, value: var): bool {
		const player = root.activePlayer
		if (!canExecute(player)) {
			root.currentTrack.title = ""
			root.currentTrack.artist = ""
			root.currentTrack.art = ""
			root.actionRequested(null, action, null)
			return false
		}

		operation(player)
		root.actionRequested(player, action, value)
		if (isAsync) settler.start()
		else {
			root.currentTrack.title = player.trackTitle
			root.currentTrack.artist = player.trackArtist
			root.currentTrack.art = player.trackArtUrl
		}
		return true
	}

	Connections {
		id: settler
		target: root.activePlayer
		enabled: false
		property string previousTrackID: ""

		function start(): void {
			enabled = true
			previousTrackID = fingerprint(target)
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
				root.currentTrack.title = target.trackTitle
				root.currentTrack.artist = target.trackArtist
				root.currentTrack.art = ""
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
			root.currentTrack.art = root.activePlayer?.trackArtUrl
		}
	}

	function describe(player: MprisPlayer): var {
		return {
			identity: player.identity,
			dbusName: player.dbusName,
			title: player.trackTitle,
			artist: player.trackArtist,
			album: player.trackAlbum,
			artUrl: player.trackArtUrl,
			position: player.position,
			length: player.length,
			playbackState: player.playbackState,
			isPlaying: player.isPlaying,
		}
	}

	GlobalShortcut {
		name: "media:play-pause"
		onPressed: root.playpause()
	}
	GlobalShortcut {
		name: "media:previous"
		onPressed: root.previous()
	}
	GlobalShortcut {
		name: "media:next"
		onPressed: root.next()
	}
	GlobalShortcut {
		name: "media:replay"
		onPressed: root.seek(-5)
	}
	GlobalShortcut {
		name: "media:skip"
		onPressed: root.seek(5)
	}
}
