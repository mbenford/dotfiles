import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.services as Services

WrapperItem {
	Text {
		id: content
		color: "#c0caf5"
		font {
			family: "Inter"
			pixelSize: 14
		}
		text: Services.Time.now
	}
}
