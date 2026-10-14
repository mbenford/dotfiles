import QtQuick

// Displays `source`, but only switches to a new value once it has stopped
// changing for `settleInterval` and the image has fully loaded.
Item {
	id: root

	// Input
	property string source: ""
	property int settleInterval: 1500
	property int fadeDuration: 300
	property int fillMode: Image.PreserveAspectCrop
	// true: empty sources are ignored (old image stays). false: empty clears the image.
	property bool ignoreEmpty: true

	// Output
	readonly property string settledSource: art   // last settled AND loaded source
	readonly property bool pending: settle.running || stage.status === Image.Loading

	property string art: ""
	property bool flip: false   // false: layer A showing, true: layer B

	onSourceChanged: {
		if (source === "" && ignoreEmpty) return
		settle.restart()
	}

	Timer {
		id: settle
		interval: root.settleInterval
		onTriggered: {
			if (root.source === "") root.art = ""   // only reachable when ignoreEmpty is false
			else stage.source = root.source
		}
	}

	// Hidden staging image: confirms the settled source actually loads
	Image {
		id: stage
		visible: false
		asynchronous: true
		onStatusChanged: if (status === Image.Ready) root.art = source
	}

	// Load into the hidden layer, then flip to crossfade
	onArtChanged: {
		const incoming = flip ? a : b
		incoming.source = art
		flip = !flip
	}

	Image {
		id: a
		anchors.fill: parent
		fillMode: root.fillMode
		opacity: root.flip ? 0 : 1
		Behavior on opacity { NumberAnimation { duration: root.fadeDuration; easing.type: Easing.InOutQuad } }
	}

	Image {
		id: b
		anchors.fill: parent
		fillMode: root.fillMode
		opacity: root.flip ? 1 : 0
		Behavior on opacity { NumberAnimation { duration: root.fadeDuration; easing.type: Easing.InOutQuad } }
	}
}
