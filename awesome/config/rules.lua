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
	})

	local ok, work = pcall(require, "work")
	if ok then
		ruled.client.append_rules(work.rules)
	end
end)

ruled.notification.connect_signal("request::rules", function()
	-- All
	ruled.notification.append_rule({
		rule = {},
		properties = {
			never_timeout = true,
			ignore = true,
			callback = function(notification)
				notification.timestamp = os.time()
			end,
		},
	})

	-- Web Apps
	local webapps = {
		["app.slack.com"] = "slack",
		["web.whatsapp.com"] = "whatsapp",
	}
	ruled.notification.append_rule({
		rule = {
			app_name = "Brave",
		},
		callback = function(notification)
			local url = notification.message:sub(1, notification.message:find("\n") - 1)
			notification.webapp_url = url
			notification.webapp_icon = webapps[url]
		end,
	})
end)
