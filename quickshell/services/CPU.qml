pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property int previousIdle: 0
	property int previousTotal: 0
	property real usage: 0.0

	Process {
	id: proc
	command: ["head", "-1", "/proc/stat"]
	running: false
	stdout: StdioCollector {
		onStreamFinished: {
		const [idle, total] = proc.parseOutput(this.text)
		const deltaIdle = idle - root.previousIdle
		const deltaTotal = total - root.previousTotal
		if (deltaTotal > 0) {
			root.usage = 1 - (deltaIdle / deltaTotal)
		}

		root.previousIdle = idle
		root.previousTotal = total
		}
	}

	function parseOutput(output: string): list<int> {
		const parts = output.trim().split(/\s+/).slice(1).map(Number)
		const idle = parts[3] + parts[4]
		const total = parts.reduce((x, y) => x + y, 0)
		return [idle, total]
	}
	}

	Timer {
	interval: 5000
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: proc.running = true
	}
}
