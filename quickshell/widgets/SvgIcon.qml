import QtQuick
import QtQuick.Shapes
import qs.icons

Item {
		id: root
		property string name
		property real size: 18
		property color color: "white"

		readonly property var vb: Paths.viewBox
		readonly property real s: size / vb[2]

		implicitWidth: size
		implicitHeight: size

		Shape {
				// scale about the top-left, then shift so the viewBox origin lands at (0,0)
				x: -root.vb[0] * root.s
				y: -root.vb[1] * root.s
				width: root.vb[2]; height: root.vb[3]
				scale: root.s
				transformOrigin: Item.TopLeft
				preferredRendererType: Shape.CurveRenderer

				ShapePath {
						fillColor: root.color
						strokeColor: "transparent"
						fillRule: ShapePath.WindingFill	// SVG's default is nonzero; Qt's default is odd-even
						PathSvg { path: Paths.paths[root.name] ?? "" }
				}
		}
}
