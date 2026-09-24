import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import qs.services as Services

Item {
	id: root

	readonly property var days: Services.Calendar.daysForViewedMonth()

	IpcHandler {
		target: "calendar"

		function toggle(): void { Services.Calendar.toggle() }
		function show(): void { Services.Calendar.show() }
		function hide(): void { Services.Calendar.hide() }
		function previousMonth(): void { Services.Calendar.previousMonth() }
		function nextMonth(): void { Services.Calendar.nextMonth() }
		function previousYear(): void { Services.Calendar.previousYear() }
		function nextYear(): void { Services.Calendar.nextYear() }
		function today(): void { Services.Calendar.resetToToday() }
	}

	LazyLoader {
		active: Services.Calendar.open

		PanelWindow {
			id: window
			WlrLayershell.namespace: "quickshell-popup"
			property bool becameActive: false
			anchors {
				top: true
				left: true
				right: true
			}
			margins.top: 38
			implicitHeight: 525
			color: "transparent"
			exclusiveZone: 0
			focusable: true
			mask: Region { item: pane }

			Rectangle {
				id: pane
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				width: 360
				height: 505
				radius: 12
				color: "#e61a1b26"
				border.width: 1
				border.color: "#33415c"

				Item {
					id: content
					anchors.fill: parent
					anchors.margins: 16
					focus: true

					Window.onActiveChanged: {
						if (Window.active)
							window.becameActive = true
						else if (window.becameActive)
							Services.Calendar.hide()
					}

					Keys.onPressed: event => {
						if (event.key === Qt.Key_Escape) {
							Services.Calendar.hide()
							event.accepted = true
						} else if (event.key === Qt.Key_Left) {
							Services.Calendar.previousMonth()
							event.accepted = true
						} else if (event.key === Qt.Key_Right) {
							Services.Calendar.nextMonth()
							event.accepted = true
						} else if (event.key === Qt.Key_Up && (event.modifiers & Qt.ControlModifier)) {
							Services.Calendar.previousYear()
							event.accepted = true
						} else if (event.key === Qt.Key_Down && (event.modifiers & Qt.ControlModifier)) {
							Services.Calendar.nextYear()
							event.accepted = true
						} else if (event.key === Qt.Key_Home) {
							Services.Calendar.resetToToday()
							event.accepted = true
						}
					}

					Component.onCompleted: forceActiveFocus()

					ColumnLayout {
						anchors.fill: parent
						spacing: 10

						ColumnLayout {
							Layout.fillWidth: true
							spacing: 0

							Text {
								Layout.fillWidth: true
								horizontalAlignment: Text.AlignHCenter
								text: Services.Time.time
								color: "#c0caf5"
								font {
									family: "Inter"
									pixelSize: 48
									bold: true
								}
							}
							Text {
								Layout.fillWidth: true
								horizontalAlignment: Text.AlignHCenter
								text: Services.Time.date
								color: "#7aa2f7"
								font {
									family: "Inter"
									pixelSize: 14
								}
							}
						}

						RowLayout {
							Layout.fillWidth: true
							spacing: 4

							Button {
								text: "«"
								Accessible.name: "Previous year"
								onClicked: Services.Calendar.previousYear()
							}
							Button {
								text: "‹"
								Accessible.name: "Previous month"
								onClicked: Services.Calendar.previousMonth()
							}
							Text {
								Layout.fillWidth: true
								horizontalAlignment: Text.AlignHCenter
								text: Qt.formatDate(new Date(Services.Calendar.viewedYear, Services.Calendar.viewedMonth, 1), "MMMM yyyy")
								color: "#c0caf5"
								font {
									family: "Inter"
									pixelSize: 18
									bold: true
								}
							}
							Button {
								text: "›"
								Accessible.name: "Next month"
								onClicked: Services.Calendar.nextMonth()
							}
							Button {
								text: "»"
								Accessible.name: "Next year"
								onClicked: Services.Calendar.nextYear()
							}
						}

						RowLayout {
							Layout.fillWidth: true
							spacing: 0
							Repeater {
								model: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
								Text {
									Layout.fillWidth: true
									horizontalAlignment: Text.AlignHCenter
									text: modelData
									color: "#7aa2f7"
									font.pixelSize: 12
								}
							}
						}

						GridLayout {
							Layout.fillWidth: true
							Layout.fillHeight: true
							columns: 7
							rowSpacing: 2
							columnSpacing: 2

							Repeater {
								model: root.days
								delegate: Item {
									required property var modelData
									Layout.fillWidth: true
									Layout.fillHeight: true

									Rectangle {
										anchors.centerIn: parent
										width: Math.min(parent.width, parent.height)
										height: width
										radius: width / 2
										color: modelData.today ? "#7aa2f7" : "transparent"

										Text {
											anchors.centerIn: parent
											text: modelData.day
											color: modelData.today ? "#1a1b26" : (modelData.currentMonth ? "#c0caf5" : "#565f89")
											font.pixelSize: 14
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
