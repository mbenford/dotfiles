local wibox = require("wibox")
local beautiful = require("beautiful")

return {
	sep = function(width)
		return wibox.widget({
			orientation = "vertical",
			thickness = 1,
			color = beautiful.separator_color,
			forced_width = width,
			widget = wibox.widget.separator,
		})
	end,

	spacer = function(width)
		return wibox.widget({
			orientation = "vertical",
			color = beautiful.wibar_bg,
			forced_width = width,
			widget = wibox.widget.separator,
		})
	end,

	label = function(label, widget)
		return wibox.widget({
			{
				{
					text = label,
					font = beautiful.widget_font,
					widget = wibox.widget.textbox,
				},
				fg = beautiful.widget_label_fg,
				widget = wibox.container.background,
			},
			widget,
			spacing = beautiful.widget_label_spacing,
			layout = wibox.layout.fixed.horizontal,
		})
	end,
}
