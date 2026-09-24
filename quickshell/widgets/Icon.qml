import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperItem {
	id: root

	required property string name
	property int size: 18

	Image {
		id: img
		source: Quickshell.shellDir + "/icons/" + root.name + ".svg"
		sourceSize: Qt.size(root.size, root.size)
	}
}
