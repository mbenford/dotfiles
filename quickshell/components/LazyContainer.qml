import Quickshell
import QtQuick

Object {
	id: root

	readonly property string state: stateGroup.state
	property Transition unloadTransition: null
	property Component component: null

	function load(): void {
		if (state === "loading" || state === "loaded") return
		if (state === "unloading") {
			Qt.callLater(() => {
				stateGroup.state = "loading"
				stateGroup.state = "loaded"
			})
			return
		}
		Qt.callLater(() => stateGroup.state = "loading")
	}
	function unload(): void {
		if (state === "unloading" || state === "unloaded") return
		Qt.callLater(() => stateGroup.state = root.unloadTransition ? "unloading" : "unloaded")
	}

	StateGroup {
		id: stateGroup
		state: "unloaded"
		states: [
			State { name: "loading" },
			State { name: "loaded" },
			State { name: "unloading" },
			State { name: "unloaded" },
		]
	}

	Connections {
		target: root.unloadTransition
		ignoreUnknownSignals: true
		function onRunningChanged() {
			if (stateGroup.state !== "unloading") return
			if (!root.unloadTransition.running) Qt.callLater(() => stateGroup.state = "unloaded")
		}
	}

	LazyLoader {
		id: loader
		active: root.state !== "unloaded"
		component: root.component
		onActiveChanged: {
			if (active) Qt.callLater(() => stateGroup.state = "loaded")
		}
	}
}

