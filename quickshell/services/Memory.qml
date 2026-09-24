pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property real usage: 0.0

	Process {
	id: proc
	command: ["head", "-3", "/proc/meminfo"]
	running: false
	stdout: StdioCollector {
		onStreamFinished: {
		const [total, free, available] = proc.parseOutput(this.text)
		root.usage = 1 - (available / total)
		}
	}

	function parseOutput(output: string): list<int> {
		return output.trim().split("\n").map(line => parseInt(line.trim().split(/\s+/)[1], 10))
	}
	}

	Timer {
	interval: 30000
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: proc.running = true
	}
}
