local wibox = require("wibox")
local beautiful = require("beautiful")

return function()
	return wibox.widget({
		widget = wibox.container.background,
		fg = beautiful.clock_fg,
		{
			widget = wibox.widget.textclock,
			font = beautiful.clock_font,
			format = "%R",
			refresh = 20,
		},
	})
end
