pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services

BasePopup {
	id: root
	autoClose: true
	autoCloseTimeout: 3000

	function onTimeout() {
		pending.remove(0)
		if (pending.count === 0) root.close()
		else root.open()
	}

	readonly property int panelWidth: 300
	readonly property int panelHeight: 80
	readonly property int padding: 16
	readonly property int imageSize: 48
	readonly property int maxHeight: 400

	ListModel {
		id: pending
	}

	Connections {
		target: Notifications
		function onNotificationAdded(notification) {
			pending.append(notification)
			root.open()
		}
	}

	window: PanelWindow {
		WlrLayershell.namespace: "quickshell.notification"
		anchors.top: true
		anchors.right: true
		margins {
			top: 5
			right: 5
		}

		implicitWidth: 400
		implicitHeight: Math.min(content.implicitHeight + padding * 2, maxHeight)
		color: "transparent"
		exclusiveZone: 0

		WrapperItem {
			Rectangle {
				id: pane
				anchors.fill: parent
				radius: 12
				color: "#80000000"

				implicitWidth: 400
				implicitHeight: Math.min(content.implicitHeight + padding * 2, maxHeight)

				RowLayout {
					id: content

					readonly property var notification: pending.count > 0 ? pending.get(0) : null

					anchors {
						fill: parent
						margins: root.padding
					}

					spacing: 12

					Image {
						Layout.preferredWidth: root.imageSize
						Layout.preferredHeight: root.imageSize
						Layout.alignment: Qt.AlignTop

						source: content.notification?.image || ""
						sourceSize: Qt.size(root.imageSize, root.imageSize)
						fillMode: Image.PreserveAspectCrop
						visible: status === Image.Ready
					}

					ColumnLayout {
						Layout.fillWidth: true
						Layout.fillHeight: true

						spacing: 6

						Text {
							Layout.fillWidth: true

							text: content.notification?.summary || ""
							textFormat: Text.PlainText
							wrapMode: Text.NoWrap
							elide: Text.ElideRight

							color: "white"
							font {
								family: "Inter"
								pixelSize: 14
								bold: true
							}
						}

						Text {
							Layout.fillWidth: true
							Layout.fillHeight: true

							text: content.notification?.body || ""
							textFormat: Text.PlainText
							elide: Text.ElideRight
							wrapMode: Text.WordWrap

							color: "#dddddd"
							clip: true
							font {
								family: "Inter"
								pixelSize: 14
							}
						}
					}
				}
			}
		}
	}
}
