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
				},
				floating = true,
			},
			properties = {
				floating = true,
				placement = awful.placement.centered,
			},
		},
	})
end)

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

-- local naughty = require("naughty")
-- naughty.connect_signal("request::display", function(n)
--     naughty.layout.box { notification = n }
-- end)

