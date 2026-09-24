import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.services

WrapperItem {
	id: root

	required property int nodeType
	readonly property string nodeTypeName: Qt.enumValueToString(Audio.NodeType, nodeType).toLowerCase()
	readonly property string iconOn: `${root.nodeTypeName}-on`
	readonly property string iconOff: `${root.nodeTypeName}-off`

	Indicator {
		icon: Audio.isMuted(root.nodeType) ? root.iconOff : root.iconOn
		value: Audio.getVolume(root.nodeType)
		hideValue: true
	}
}
