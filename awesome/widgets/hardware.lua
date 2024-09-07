local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local util = require("widgets.util")
local fn = require("util.fn")

return {
	cpu = function()
		local thresholds = {
			{ 90, beautiful.threshold_critical_fg },
			{ 80, beautiful.threshold_high_fg },
			{ 70, beautiful.threshold_medium_fg },
			normal = beautiful.threshold_normal_fg,
		}

		local widget = wibox.widget({ font = beautiful.widget_font, widget = wibox.widget.textbox })
		vicious.register(widget, vicious.widgets.cpu, function(_, args)
			local value = math.max(args[1], 1)
			local color = fn.map_threshold(value, thresholds)
			return fn.span(color, "%02d%%", value)
		end, 5)

		return util.label("CPU", widget)
	end,

	mem = function()
		local thresholds = {
			{ 90, beautiful.threshold_critical_fg },
			{ 70, beautiful.threshold_high_fg },
			{ 50, beautiful.threshold_medium_fg },
			normal = beautiful.threshold_normal_fg,
		}

		local widget = wibox.widget({ font = beautiful.widget_font, widget = wibox.widget.textbox })
		vicious.register(widget, vicious.widgets.mem, function(_, args)
			local color = fn.map_threshold(args[1], thresholds)
			return fn.span(color, "%02d%%", args[1])
		end, 7)

		return util.label("RAM", widget)
	end,

	ssd = function()
		local widget = wibox.widget({ font = beautiful.widget_font, widget = wibox.widget.textbox })
		vicious.register(widget, vicious.widgets.fs, function(_, args)
			return fn.span(beautiful.threshold_normal_fg, "%dG", math.floor(args["{/ avail_gb}"]))
		end, 61)

		return util.label("SSD", widget)
	end,
}
