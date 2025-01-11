local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local lgi = require("lgi")
local icons = require("icons")
local util = require("widgets.util")
local fn = require("util.fn")
local Gio = lgi.Gio

local upower = lgi.UPowerGlib.Client()
local batt_device = upower:get_display_device()

return {
	cpu = function()
		local thresholds = {
			normal = beautiful.threshold_normal_fg,
			{ 90, beautiful.threshold_critical_fg },
			{ 80, beautiful.threshold_high_fg },
			{ 70, beautiful.threshold_medium_fg },
		}

		local widget = wibox.widget({
			widget = wibox.widget.textbox,
			font = beautiful.widget_font,
		})
		vicious.register(widget, vicious.widgets.cpu, function(_, args)
			local value = math.max(args[1], 1)
			local color = fn.map_threshold(value, thresholds)
			return fn.span(color, "%02d%%", value)
		end, 5)

		return util.icon("indicator-cpufreq", widget)
		-- return util.label("CPU", widget)
	end,
	mem = function()
		local thresholds = {
			normal = beautiful.threshold_normal_fg,
			{ 90, beautiful.threshold_critical_fg },
			{ 80, beautiful.threshold_high_fg },
			{ 70, beautiful.threshold_medium_fg },
		}

		local widget = wibox.widget({
			widget = wibox.widget.textbox,
			font = beautiful.widget_font,
		})
		vicious.register(widget, vicious.widgets.mem, function(_, args)
			local color = fn.map_threshold(args[1], thresholds)
			return fn.span(color, "%02d%%", args[1])
		end, 10)

		return util.icon("indicator-sensors-memory", widget)
		-- return util.label("MEM", widget)
	end,
	disk = function()
		local widget = wibox.widget({
			widget = wibox.widget.textbox,
			font = beautiful.widget_font,
		})
		vicious.register(widget, vicious.widgets.fs, function(_, args)
			return fn.span(beautiful.threshold_normal_fg, "%d%%", math.floor(args["{/ used_p}"]))
		end, 60)

		return util.icon("indicator-sensors-disk", widget)
		-- return util.label("SSD", widget)
	end,
	battery = function()
		local icon = wibox.widget({
			widget = icons.system.icon,
			size = 16,
		})

		local function update(device)
			local percentage = math.floor(device.percentage / 10) * 10
			local icon_name = string.format("battery-%03d", percentage)
			icon.name = icon_name .. (device.state == 1 and "-charging" or "")
			icon.visible = device.state ~= 4
		end
		batt_device.on_notify = update

		update(batt_device)
		return icon
	end,
}
