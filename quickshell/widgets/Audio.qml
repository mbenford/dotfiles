import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services

RowLayout {
	id: root

	required property string type
	readonly property string iconOn: `${type}-on`
	readonly property string iconOff: `${type}-off`

	Indicator {
		icon: Audio.isMuted(root.type) ? root.iconOff : root.iconOn
		iconSize: 20
		value: Audio.getVolume(root.type)
		hideValue: true
	}
}
