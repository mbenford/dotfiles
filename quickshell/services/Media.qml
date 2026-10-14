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

	signal mediaAction(action: string, player: MprisPlayer, value: var)

	function play(playerName: string): bool {
		return run(playerName, "play", p => p.canPlay, p => p.play())
	}
	function pause(playerName: string): bool {
		return run(playerName, "pause", p => p.canPause, p => p.pause())
	}
	function playpause(playerName: string): bool {
		return run(playerName, "playpause", p => p.canTogglePlaying, p => p.togglePlaying())
	}
	function stop(playerName: string): bool {
		return run(playerName, "stop", p => p.canControl, p => p.stop())
	}
	function next(playerName: string): bool {
		return run(playerName, "next", p => p.canGoNext, p => p.next())
	}
	function previous(playerName: string): bool {
		return run(playerName, "prev", p => p.canGoPrevious, p => p.previous())
	}
	function seek(offset: int, playerName: string): bool {
		return run(playerName, "seek", p => p.canSeek, p => p.seek(offset), offset)
	}
	function setPosition(seconds: int, playerName: string): bool {
		return run(playerName, "setPosition", p => p.canSeek && p.positionSupported, p => { p.position = seconds }, seconds)
	}

	function run(playerName: string, action: string, canExecute: bool, operation, value: var): bool {
		const players = resolve(playerName).filter(canExecute)
		if (players.length === 0) {
			root.mediaAction(action, null, null)
			return false
		}

		players.forEach(p => {
			operation(p)
			root.mediaAction(action, p, value)
		})
		return true
	}

	function resolve(playerName: string): list<MprisPlayer> {
		if (!playerName) return root.activePlayer ? [root.activePlayer] : []

		const all = Mpris.players.values
		if (playerName === "*") return all.filter(() => true)

		const name = playerName.toLowerCase()
		return all.filter(p => p.identity.toLowerCase() === name
			|| p.desktopEntry.toLowerCase() === name
			|| p.dbusName.toLowerCase().includes(name))
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
		onPressed: root.playpause("*")
	}
	GlobalShortcut {
		name: "media:previous"
		onPressed: root.previous("*")
	}
	GlobalShortcut {
		name: "media:next"
		onPressed: root.next("*")
	}
	GlobalShortcut {
		name: "media:replay"
		onPressed: root.seek(-5, "*")
	}
	GlobalShortcut {
		name: "media:skip"
		onPressed: root.seek(5, "*")
	}
}
