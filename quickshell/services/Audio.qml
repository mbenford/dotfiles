pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
	id: root

	enum NodeType {
		Sink,
		Source
	}

	function getNode(type: int): PwNodeAudio {
		const node = type === Audio.NodeType.Sink
			? Pipewire.defaultAudioSink
			: Pipewire.defaultAudioSource

		return node.ready ? node.audio : null
	}

	function getVolume(type: int): real {
		return root.getNode(type)?.volume || 0
	}

	function isMuted(type: int): bool {
		return root.getNode(type)?.muted | false
	}

	signal nodeUpdated(nodeType: int)

	Connections {
		readonly property int nodeType: Audio.NodeType.Sink

		target: Pipewire.defaultAudioSink.audio
		function onVolumeChanged(value) {
			root.nodeUpdated(nodeType)
		}
		function onMutedChanged() {
			root.nodeUpdated(nodeType)
		}
	}
	Connections {
		readonly property int nodeType: Audio.NodeType.Source

		target: Pipewire.defaultAudioSource.audio
		function onVolumeChanged(value) {
			root.nodeUpdated(nodeType)
		}
		function onMutedChanged() {
			root.nodeUpdated(nodeType)
		}
	}

	PwObjectTracker {
		objects: [
			Pipewire.defaultAudioSink,
			Pipewire.defaultAudioSource,
		]
	}
}
