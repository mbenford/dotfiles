import QtQuick

Rectangle {
	id: root
	required property real value
	property color fillColor: "limegreen"

	height: 10
	radius: height / 2
	color: "gray"
	clip: true

	Rectangle {
		height: parent.height
		width: parent.width * root.value
		radius: parent.radius
		color: root.fillColor
	}
}
