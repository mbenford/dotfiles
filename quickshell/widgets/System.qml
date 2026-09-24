import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services

RowLayout {
	id: root
	spacing: 15

	Indicator {
		label: "CPU"
		value: CPU.usage
	}
	Indicator {
		label: "MEM"
		value: Memory.usage
	}
	Indicator {
		label: "SSD"
		value: Disk.usage
	}
}
