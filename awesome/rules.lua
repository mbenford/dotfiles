local ruled = require("ruled")
local awful = require("awful")

ruled.client.connect_signal("request::rules", function()
	ruled.client.append_rules({
		-- All
		{
			id = "global",
			rule = {},
			properties = {
				focus = awful.client.focus.filter,
				raise = true,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			},
		},
		-- Floating
		{
			id = "floating",
			rule_any = {
				class = {
					"Arandr",
					"Blueman-manager",
					"Lxappearance",
					"Nm-connection-editor",
					"pavucontrol",
					"Qalculate-gtk",
					"Xfce4-power-manager-settings",
				},
				instance = {
					"flameshot",
					"guvcview",
					"system-config-printer",
				},
				floating = true,
			},
			properties = {
				floating = true,
				placement = awful.placement.centered,
				ontop = true,
			},
		},
		-- Messaging
		{
			id = "communication",
			rule_any = {
				instance = {
					"gmail.com",
					"web.whatsapp.com",
					"web.telegram.org",
				},
			},
			properties = {
				tag = "4",
				screen = 2,
				switch_to_tags = true,
			},
		},
		-- Work,
		{
			id = "work",
			rule_any = {
				instance = {
					"discord",
					"slack",
					"teams-for-linux",
					"outlook.office.com",
				},
			},
			properties = {
				tag = "1",
				screen = 2,
				switch_to_tags = true,
			},
		},
	})
end)

ruled.notification.connect_signal("request::rules", function()
	ruled.notification.append_rule({
		rule = {
			app_name = "Slack",
		},
		properties = {
			app_icon = "slack",
		},
	})
end)
