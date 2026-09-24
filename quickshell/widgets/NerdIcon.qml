import QtQuick

Item {
	id: root

	required property int codePoint
	property color color: "#ffffff"
	property int size: 18

	Text {
	id: txt
	font {
		family: "Symbols Nerd Font"
		pixelSize: root.size
	}
	text: String.fromCodePoint(root.codePoint)
	color: root.color
	}
}
