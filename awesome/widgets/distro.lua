local wibox = require("wibox")
local beautiful = require("beautiful")

return function()
	return wibox.widget({
		widget = wibox.container.background,
		fg = beautiful.distro_fg,
		{
			widget = wibox.widget.textbox,
			font = "Symbols Nerd Font 16",
			text = "󰣇",
		},
	})
end
