pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
	id: root

	readonly property int historySize: 20
	readonly property list<Notification> notifications: server.trackedNotifications.values
	signal notificationAdded(notification: Notification)

	NotificationServer {
		id: server

		keepOnReload: false
		bodySupported: true
		imageSupported: true

		onNotification: notification => {
			notification.tracked = !notification.transient
			root.notificationAdded(notification)

			if (server.trackedNotifications.values.length > root.historySize) {
				const oldest = server.trackedNotifications.values[0]
				oldest.dismiss()
			}
		}
	}
}
