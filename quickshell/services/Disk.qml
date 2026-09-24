pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property real usage: 0.0

	Process {
	id: proc
	command: ["df", "-P", "/"]
	running: false
	stdout: StdioCollector {
		onStreamFinished: {
		const [used, total] = proc.parseOutput(this.text)
		root.usage = used / total
		}
	}

	function parseOutput(output: string): list<int> {
		const parts = output.trim().split("\n")[1].trim().split(/\s+/)
		const total = parseInt(parts[1], 10)
		const used = parseInt(parts[2], 10)
		return [used, total]
		}
	}

	Timer {
	interval: 60000
	running: true
	repeat: true
	triggeredOnStart: true
	onTriggered: proc.running = true
	}
}
