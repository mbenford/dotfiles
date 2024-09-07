local awful = require("awful")
local wibox = require("wibox")

return function(screen)
	return wibox.widget({
		widget = wibox.container.place,
		{
			widget = awful.widget.layoutbox,
			screen = screen,
			forced_width = 20,
		},
	})
end
