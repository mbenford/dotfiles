local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local ezbuttons = require("util.ez").ezbuttons
local func = require("util.func")
local pulseaudio = require("util.pulseaudio")
vicious.contrib = require("vicious.contrib")

local api = { awesome = awesome, client = client, tag = tag }

local M = {}

local function with_label(label, widget)
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
end

function M.systray()
	return wibox.widget({
		{
			base_size = 22,
			widget = wibox.widget.systray(),
		},
		valign = "center",
		widget = wibox.container.place,
	})
end

function M.distro()
	return wibox.widget({
		{
			text = "󰣇",
			font = "Symbols Nerd Font 16",
			widget = wibox.widget.textbox,
		},
		fg = beautiful.distro_fg,
		widget = wibox.container.background,
	})
end

function M.clock()
	return wibox.widget({
		{
			format = "%R",
			refresh = 20,
			font = beautiful.clock_font,
			widget = wibox.widget.textclock,
		},
		fg = beautiful.clock_fg,
		widget = wibox.container.background,
	})
end

function M.taglist(screen)
	local templates = {}
	templates.standard = {
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
	}
	templates.circles = {
		{
			{
				{
					id = "content",
					font = "Symbols Nerd Font 12",
					widget = wibox.widget.textbox,
				},
				left = 3,
				right = 3,
				widget = wibox.container.margin,
			},
			id = "background",
			widget = wibox.container.background,
		},
		layout = wibox.layout.align.horizontal,
		create_callback = function(self, t)
			templates.circles.update_callback(self, t)
		end,
		update_callback = function(self, t)
			local content = self:get_children_by_id("content")[1]
			local background = self:get_children_by_id("background")[1]

			if t.selected then
				content.text = beautiful.taglist_circles_selected
				background.fg = beautiful.taglist_fg_focus
			else
				if #t:clients() > 0 then
					content.text = beautiful.taglist_circles_not_empty
					background.fg = beautiful.taglist_fg_not_empty
				else
					content.text = beautiful.taglist_circles_empty
					background.fg = beautiful.taglist_fg
				end
			end

			if t.urgent then
				background.fg = beautiful.fg_urgent
			end
		end,
	}

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
		widget_template = templates[beautiful.taglist_style],
	})
end

function M.tasklist(screen)
	return awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = ezbuttons({
			["1"] = function(c)
				if c == api.client.focus then
					c.minimized = true
				else
					c:emit_signal("request::activate", "tasklist", { raise = true })
				end
			end,
		}),
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						valign = true,
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
	})
end

function M.window_name(screen)
	local content = wibox.widget.textbox()
	content.font = beautiful.window_name_font

	local function update_name(c)
		if c.screen == screen and api.client.focus == c then
			content.text = c.name
		end
	end
	local function clear_title(t)
		if t.screen == screen and #t:clients() == 0 then
			content.text = ""
		end
	end

	api.client.connect_signal("focus", update_name)
	api.client.connect_signal("property::name", update_name)
	api.tag.connect_signal("untagged", clear_title)
	api.tag.connect_signal("property::selected", clear_title)

	return wibox.widget({
		{
			content,
			widget = wibox.container.margin,
		},
		fg = beautiful.window_name_fg,
		bg = beautiful.window_name_bg,
		widget = wibox.container.background,
	})
end

function M.window_count(screen)
	local content = wibox.widget.textbox()
	content.font = beautiful.window_count_font

	local function update_count(t)
		if t.screen == screen then
			local count = #t:clients()
			if t.layout == awful.layout.suit.max and count > 1 then
				content.text = count
			else
				content.text = ""
			end
		end
	end

	api.tag.connect_signal("tagged", update_count)
	api.tag.connect_signal("untagged", update_count)
	api.tag.connect_signal("cleared", update_count)
	api.tag.connect_signal("property::selected", update_count)
	api.tag.connect_signal("property::layout", update_count)

	return wibox.widget({
		{
			content,
			widget = wibox.container.margin,
		},
		fg = beautiful.window_count_fg,
		bg = beautiful.window_count_bg,
		widget = wibox.container.background,
	})
end

function M.layoutbox(screen)
	return wibox.widget({
		{
			screen = screen,
			forced_width = 20,
			widget = awful.widget.layoutbox,
		},
		widget = wibox.container.place,
	})
end

function M.cpu()
	local thresholds = {
		{ 90, beautiful.threshold_critical_fg },
		{ 80, beautiful.threshold_high_fg },
		{ 70, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}

	local widget = wibox.widget({ font = beautiful.widget_font, widget = wibox.widget.textbox })
	vicious.register(widget, vicious.widgets.cpu, function(_, args)
		local value = math.max(args[1], 1)
		local color = func.map_threshold(value, thresholds)
		return func.span(color, "%02d%%", value)
	end, 5)

	return with_label("CPU", widget)
end

function M.ram()
	local thresholds = {
		{ 90, beautiful.threshold_critical_fg },
		{ 70, beautiful.threshold_high_fg },
		{ 50, beautiful.threshold_medium_fg },
		normal = beautiful.threshold_normal_fg,
	}

	local widget = wibox.widget({ font = beautiful.widget_font, widget = wibox.widget.textbox })
	vicious.register(widget, vicious.widgets.mem, function(_, args)
		local color = func.map_threshold(args[1], thresholds)
		return func.span(color, "%02d%%", args[1])
	end, 7)

	return with_label("RAM", widget)
end

function M.ssd()
	local widget = wibox.widget({ font = beautiful.widget_font, widget = wibox.widget.textbox })
	vicious.register(widget, vicious.widgets.fs, function(_, args)
		return func.span(beautiful.threshold_normal_fg, "%dG", math.floor(args["{/ avail_gb}"]))
	end, 61)

	return with_label("SSD", widget)
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
		local color = func.map_threshold(args[1], thresholds)
		return func.span(color, "PKG:%d", args[1])
	end, 60 * 60, "Arch C")
	return widget
end

function M.pulseaudio_sink()
	local content = wibox.widget.textbox()
	content.font = beautiful.widget_font

	pulseaudio.connect_signal("sink::volume", function(volume)
		content.markup = string.format("%02d%%", volume)
	end)
	pulseaudio.connect_signal("sink::mute", function()
		content.markup = "MUTE"
	end)
	pulseaudio.refresh_sink_volume()

	local widget = wibox.widget({
		{
			content,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
	})

	return with_label("VOL", widget)
end

function M.pulseaudio_source()
	local content = wibox.widget.textbox()
	content.font = beautiful.widget_font

	pulseaudio.connect_signal("source::volume", function(volume)
		content.markup = string.format("%02d%%", volume)
	end)
	pulseaudio.connect_signal("source::mute", function()
		content.markup = "MUTE"
	end)
	pulseaudio.refresh_source_volume()

	local widget = wibox.widget({
		{
			content,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
	})

	return with_label("MIC", widget)
end

function M.wifi(interface)
	local widget = wibox.widget.textbox()
	vicious.register(widget, vicious.widgets.wifiiw, function(_, args)
		return func.span(beautiful.wifi_ssid_fg, "%s", args["{ssid}"])
	end, 11, interface)
	return widget
end

function M.netstats(label, interface)
	local widget = wibox.widget.textbox()
	local get_prop = function(args, property)
		return args[string.format("{%s %s}", interface, property)]
	end

	vicious.register(widget, vicious.widgets.net, function(_, args)
		if get_prop(args, "carrier") == 0 then
			return ""
		end

		local down_kb = get_prop(args, "down_kb")
		return string.format(
			"%s  %s",
			func.span(beautiful.widget_label_fg, label),
			func.span(beautiful.threshold_normal_fg, "%skb", down_kb)
		)
	end, 3, interface)
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
	vicious.register(widget, vicious.contrib.sensors, function(_, args)
		local color = func.map_threshold(args[1], thresholds)
		return func.span(color, "TEMP:%sC", args[1])
	end, 7, "Package id 0")
	return widget
end

function M.sep(width)
	return wibox.widget({
		orientation = "vertical",
		thickness = 1,
		color = beautiful.separator_color,
		forced_width = width,
		widget = wibox.widget.separator,
	})
end

function M.spacer(width)
	return wibox.widget({
		orientation = "vertical",
		color = beautiful.wibar_bg,
		forced_width = width,
		widget = wibox.widget.separator,
	})
end

return M
