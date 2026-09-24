import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	spacing: 5

	property string icon: ""
	property list<string> icons: []
	property string label: ""
	property real value: 0.0
	property color color: "#ffffff"
	property bool hideValue: false

	Icon {
		id: icon
		name: {
			if (root.icon !== "") return root.icon
			if (root.icons.length > 0) {
				let index = Math.trunc(root.value / (1 / root.icons.length))
				index = Math.min(root.icons.length - 1, index)
				return root.icons[index]
			}
			return ""
		}
		size: 20
		visible: root.icon !== "" || root.icons.length > 0
	}

	Text {
		text: root.label
		font {
			family: "JetBrains Mono"
			pixelSize: 14
		}
		color: root.color
		visible: root.label !== ""
	}

	Text {
		font {
			family: "JetBrains Mono"
			pixelSize: 14
		}
		text: `${(root.value * 100).toFixed(0)}%`
		color: root.color
		visible: !root.hideValue
	}
}
