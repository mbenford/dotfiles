local awful = require("awful")
local wibox = require("wibox")

return function(screen)
	return awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		widget_template = {
			id = "background_role",
			widget = wibox.container.background,
			{
				layout = wibox.layout.align.horizontal,
				{
					widget = wibox.container.margin,
					left = 5,
					right = 5,
					{
						widget = wibox.container.place,
						valign = true,
						{
							widget = wibox.widget.imagebox,
							id = "icon_role",
						},
					},
				},
				{
					widget = wibox.container.margin,
					right = 5,
					{
						widget = wibox.widget.textbox,
						id = "text_role",
					},
				},
			},
		},
	})
end
