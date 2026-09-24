pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	readonly property string now: {
		return Qt.formatDateTime(clock.date, "ddd dd, hh:mm")
	}
	readonly property string time: Qt.formatDateTime(clock.date, "hh:mm")
	readonly property string date: Qt.formatDateTime(clock.date, "dddd, MMMM d, yyyy")

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
