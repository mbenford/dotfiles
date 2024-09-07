local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local lgi = require("lgi")

return function()
	local name = wibox.widget.textbox()
	local icon = wibox.widget({
		text = "",
		font = "Symbols Nerd Font 12",
		widget = wibox.widget.textbox,
	})

	local nm_client = lgi.NM.Client.new()

	gears.timer({
		timeout = 10,
		call_now = true,
		autostart = true,
		callback = function()
			for _, conn in ipairs(nm_client:get_active_connections()) do
				if conn.vpn then
					name.markup = conn.id
					return
				end
			end
			name.markup = "N/A"
		end,
	})

	return wibox.widget({
		{
			icon,
			fg = beautiful.widget_label_fg,
			widget = wibox.container.background,
		},
		name,
		spacing = 5,
		layout = wibox.layout.fixed.horizontal,
	})
end
