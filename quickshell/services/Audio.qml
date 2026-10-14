pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
	id: root

	function getNode(type: string): PwNodeAudio {
		const node = type === "sink"
			? Pipewire.defaultAudioSink
			: Pipewire.defaultAudioSource

		return node.ready ? node.audio : null
	}

	function getVolume(type: string): int {
		const volume = getNode(type)?.volume.toFixed(2) || 0.00
		return Math.trunc(volume * 100)
	}

	function setVolume(type: string, offset: int): void {
		const node = getNode(type)
		if (node === null) return

		const volume = Math.max(0, Math.min(1, node.volume + offset / 100))
		if (volume === node.volume) {
			nodeUpdated(type)
			return
		}

		node.volume = Math.max(0, Math.min(1, node.volume + offset / 100))
	}

	function isMuted(type: string): bool {
		return getNode(type)?.muted | false
	}

	function toggleMute(type: string): void {
		const node = getNode(type)
		if (node === null) return

		node.muted = !node.muted
	}

	signal nodeUpdated(type: string)

	Connections {
		target: Pipewire.defaultAudioSink.audio

		readonly property string type: "sink"
		property int lastVolume: -1
		property bool lastMuted: false

		function onVolumeChanged() {
			const volume = Math.round(target.volume * 100)
			if (volume === lastVolume) return
			lastVolume = volume
			root.nodeUpdated(type)
		}
		function onMutedChanged() {
			if (lastMuted === target.muted) return
			lastMuted = target.muted
			root.nodeUpdated(type)
		}
	}
	Connections {
		target: Pipewire.defaultAudioSource.audio

		readonly property string type: "source"
		property int lastVolume: -1
		property bool lastMuted: false

		function onVolumeChanged() {
			const volume = Math.round(target.volume * 100)
			if (volume === lastVolume) return
			lastVolume = volume
			root.nodeUpdated(type)
		}
		function onMutedChanged() {
			if (lastMuted === target.muted) return
			lastMuted = target.muted
			root.nodeUpdated(type)
		}
	}

	PwObjectTracker {
		objects: [
			Pipewire.defaultAudioSink,
			Pipewire.defaultAudioSource,
		]
	}

	GlobalShortcut {
		name: "audio:sink:volume-up"
		onPressed: root.setVolume("sink", 5)
	}
	GlobalShortcut {
		name: "audio:sink:volume-down"
		onPressed: root.setVolume("sink", -5)
	}
	GlobalShortcut {
		name: "audio:sink:mute"
		onPressed: root.toggleMute("sink")
	}
	GlobalShortcut {
		name: "audio:source:volume-up"
		onPressed: root.setVolume("source", 5)
	}
	GlobalShortcut {
		name: "audio:source:volume-down"
		onPressed: root.setVolume("source", -5)
	}
	GlobalShortcut {
		name: "audio:source:mute"
		onPressed: root.toggleMute("source")
	}
}
