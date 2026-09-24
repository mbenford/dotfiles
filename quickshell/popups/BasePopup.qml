pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Item {
	id: root

	property bool active: false
	property bool autoClose: true
	property int autoCloseTimeout: 1000
	required property Component window

	function open(): void {
		active = true
		if (autoClose) timer.restart()
	}

	function close(): void {
		active = false
		timer.stop()
	}

	function onTimeout(): void {
		active = false
	}

	Timer {
		id: timer
		interval: root.autoCloseTimeout
		onTriggered: root.onTimeout()
	}

	LazyLoader {
		active: root.active
		component: root.window
	}
}
