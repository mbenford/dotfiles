pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  property OSD active: null

  function enter(osd: OSD): void {
	active = osd
	timer.restart()
  }
  function release(osd: OSD): void {
	if (active === osd) {
	  active = null
	  timer.stop()
	}
  }

  Timer {
	id: timer
	interval: root.active?.interval || 0
	onTriggered: root.active = null
  }
}
