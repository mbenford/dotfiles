import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.services

OSD {
	id: root

	property int nodeType
	readonly property string nodeTypeName: Qt.enumValueToString(Audio.NodeType, nodeType).toLowerCase()
	readonly property string iconOn: `${nodeTypeName}-on`
	readonly property string iconOff: `${nodeTypeName}-off`

	Connections {
		target: Audio
		function onNodeUpdated(nodeType: int) {
			root.nodeType = nodeType
			root.open()
		}
	}

	content: RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30

		Icon {
			name: Audio.isMuted(root.nodeType) ? root.iconOff : root.iconOn
			size: 48
		}
		ProgressBar {
			Layout.fillWidth: true
			value: Audio.getVolume(root.nodeType)
			fillColor: Audio.isMuted(root.nodeType) ? "gray" : "limegreen"
		}
		Text {
			Layout.preferredWidth: 30
			horizontalAlignment: Text.AlignHCenter
			text: {
				const volume = Audio.getVolume(root.nodeType) * 100
				return `${volume.toFixed(0)}`
			}
			font {
				family: "Inter"
				pixelSize: 18
			}
			color: "white"
		}
	}
}
