local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")

return {
	sep = function(width)
		return wibox.widget({
			widget = wibox.widget.separator,
			orientation = "vertical",
			thickness = 1,
			color = beautiful.separator_color,
			forced_width = width,
		})
	end,

	spacer = function(width)
		return wibox.widget({
			widget = wibox.widget.separator,
			orientation = "vertical",
			color = beautiful.wibar_bg,
			forced_width = width,
		})
	end,

	label = function(label, widget)
		return wibox.widget({
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.widget_label_spacing,
			{
				widget = wibox.container.background,
				fg = beautiful.widget_label_fg,
				{
					widget = wibox.widget.textbox,
					text = label,
					font = "Jetbrains Mono 11",
				},
			},
			widget,
		})
	end,

	icon = function(icon, widget)
		return wibox.widget({
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.widget_label_spacing,
			{
				widget = wibox.container.background,
				fg = beautiful.widget_label_fg,
				{
					widget = icons.system.icon,
					name = icon,
					size = 16,
				},
			},
			widget,
		})
	end,
}
