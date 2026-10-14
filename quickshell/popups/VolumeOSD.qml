pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.services

OSD {
	id: root
	property string type

	Connections {
		target: Audio
		function onNodeUpdated(type: string) {
			root.type = type
			root.show()
		}
	}

	content: RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 30
		anchors.rightMargin: 30

		Icon {
			name: Audio.isMuted(root.type) ? `${root.type}-off` : `${root.type}-on`
			size: 48
		}
		SvgIcon {
			name: Audio.isMuted(root.type) ? `${root.type}-off` : `${root.type}-on`
			color: "#e3e3e3"
			size: 48
		}
		ProgressBar {
			Layout.fillWidth: true
			value: Audio.getVolume(root.type) / 100
			fillColor: Audio.isMuted(root.type) ? "gray" : "limegreen"
		}
		Text {
			Layout.preferredWidth: 30
			horizontalAlignment: Text.AlignHCenter
			text: Audio.getVolume(root.type)
			font {
				family: "Inter"
				pixelSize: 18
			}
			color: "white"
		}
	}
}
