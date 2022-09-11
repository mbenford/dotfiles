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
					"Pavucontrol",
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
			},
		},
		-- Apps
		{
			id = "work",
			rule_any = {
				instance = {
					".*.slack.com",
					"teams.microsoft.com",
					"outlook.office.com",
				},
			},
			properties = {
				tag = "0",
				switch_to_tags = true,
			},
		},
	})
end)

ruled.notification.connect_signal("request::rules", function()
	-- All notifications will match this rule.
	ruled.notification.append_rule({
		rule = {},
		properties = {
			screen = awful.screen.preferred,
			implicit_timeout = 5,
		},
	})
end)
