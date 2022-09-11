local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local ezbuttons = require("util.ez").ezbuttons
local util = require("util.func")
vicious.contrib = require("vicious.contrib")

local capi = { client = client }

local M = {}

function M.clock()
	return wibox.widget.textclock("%b %d %H:%M", 20)
end

function M.taglist(screen)
	return awful.widget.taglist({
		screen = screen,
		buttons = ezbuttons({
			["1"] = function(t)
				t:view_only()
			end,
		}),
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 3,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			nil,
			{
				{
					id = "text_role",
					widget = wibox.widget.textbox,
				},
				top = 2,
				left = 6,
				right = 6,
				widget = wibox.container.margin,
			},
			{
				wibox.widget.base.make_widget(),
				id = "background_role",
				forced_height = 2,
				widget = wibox.container.background,
			},
			layout = wibox.layout.align.vertical,
		},
	})
end

function M.tasklist(screen)
	return awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = ezbuttons({
			["1"] = function(c)
				if c == capi.client.focus then
					c.minimized = true
				else
					c:emit_signal("request::activate", "tasklist", { raise = true })
				end
			end,
		}),
		style = {
			spacing = 5,
		},
		layout = wibox.layout.fixed.horizontal(),
		widget_template = {
			{
				{
					{
						{
							{
								id = "icon_role",
								widget = wibox.widget.imagebox,
							},
							forced_width = 16,
							widget = wibox.container.place,
						},
						left = 5,
						right = 5,
						widget = wibox.container.margin,
					},
					{
						{
							id = "text_role",
							widget = wibox.widget.textbox,
						},
						right = 5,
						widget = wibox.container.margin,
					},
					layout = wibox.layout.align.horizontal,
				},
				id = "background_role",
				widget = wibox.container.background,
			},
			width = 300,
			strategy = "exact",
			widget = wibox.container.constraint,
		},
	})
end

function M.layoutbox(screen)
	return wibox.container.place(awful.widget.layoutbox({
		screen = screen,
		forced_width = 20,
	}))
end

function M.cpu()
	local thresholds = {
		{ 90, beautiful.threshold_critical_fg },
		{ 80, beautiful.threshold_high_fg },
		{ 70, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}

	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.widgets.cpu, function(_, args)
		local value = args[1] > 0 and args[1] or 1
		local color = util.map_threshold(value, thresholds)
		return util.span(color, "CPU:%d%%", value)
	end, 5)
	return widget
end

function M.memory()
	local thresholds = {
		{ 90, beautiful.threshold_critical_fg },
		{ 70, beautiful.threshold_high_fg },
		{ 50, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}

	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.widgets.mem, function(_, args)
		local color = util.map_threshold(args[1], thresholds)
		return util.span(color, "MEM:%d%%", args[1])
	end, 7)
	return widget
end

function M.disk()
	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.widgets.fs, function(_, args)
		return util.span(beautiful.threshold_normal_fg, "SSD:%dG", math.floor(args["{/ avail_gb}"]))
	end, 61)
	return widget
end

function M.packages()
	local thresholds = {
		{ 100, beautiful.threshold_critical_fg },
		{ 70, beautiful.threshold_high_fg },
		{ 50, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}
	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.widgets.pkg, function(w, args)
		local color = util.map_threshold(args[1], thresholds)
		return util.span(color, "PKG:%d", args[1])
	end, 60 * 60, "Arch C")
	return widget
end

function M.volume()
	local thresholds = {
		{ 99, beautiful.threshold_critical_fg },
		{ 90, beautiful.threshold_high_fg },
		{ 70, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}
	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.contrib.pulse, function(_, args)
		local color = util.map_threshold(args[1], thresholds)
		return util.span(color, "VOL:%d%%", args[1])
	end, 50)
	return widget
end

function M.wifi()
	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.widgets.wifiiw, function (_, args)
		return util.span(beautiful.threshold_normal_fg, "WIFI:%s%%", args["{linp}"])
	end, 11, "wlan0")
	return widget
end

function M.cpu_temp()
	local thresholds = {
		{ 90, beautiful.threshold_critical_fg },
		{ 85, beautiful.threshold_high_fg },
		{ 80, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}

	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.contrib.sensors, function (_, args)
		local color = util.map_threshold(args[1], thresholds)
		return util.span(color, "TEMP:%sC", args[1])
	end, 7, "Package id 0")
	return widget
end

function M.sep(width)
	return wibox.widget({
		widget = wibox.widget.separator,
		orientation = "vertical",
		color = "#353535",
		forced_width = width,
	})
end

function M.spacer(width)
	return wibox.widget({
		widget = wibox.widget.separator,
		orientation = "vertical",
		color = "#21252b",
		forced_width = width,
	})
end

return M
