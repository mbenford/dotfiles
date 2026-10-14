import QtQuick

Text {
	property string name
	property real size: 14
	property bool filled: true
	property int weight: 400
	property string variation: "Outlined"

	text: name
	color: "white"
	font {
		family: `Material Symbols ${variation}`
		pixelSize: size
		variableAxes: ({ "FILL": filled ? 1 : 0, "wght": weight })
	}
	verticalAlignment: Text.AlignVCenter
	horizontalAlignment: Text.AlignHCenter
	renderType: Text.CurveRendering
}
