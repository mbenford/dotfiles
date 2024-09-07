local wibox = require("wibox")

return function()
	return wibox.widget({
		widget = wibox.container.place,
		valign = "center",
		{
			widget = wibox.widget.systray(),
			base_size = 22,
		},
	})
end
