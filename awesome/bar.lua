local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")

local api = { screen = screen }

api.screen.connect_signal("request::desktop_decoration", function(screen)
	local tags = { "1", "2", "3", "4" }
	for _, tag in ipairs(tags) do
		awful.tag.add(tag, {
			layout = awful.layout.suit.tile,
			screen = screen,
			enable_padding = true,
		})
	end

	local padding = widgets.spacer(10)
	local spacer = widgets.spacer(10)
	local sep = widgets.sep(15)

	local left = {
		padding,
		widgets.taglist(screen),
		spacer,
		widgets.layoutbox(screen),
		spacer,
		widgets.window_count(screen),
		layout = wibox.layout.fixed.horizontal,
	}
	local middle = {
		widgets.window_name(screen),
		layout = wibox.layout.ratio.horizontal,
	}
	local right = {
		widgets.clock(),
		padding,
		layout = wibox.layout.fixed.horizontal,
	}

	if screen == api.screen.primary then
		right = gears.table.join({
			spacer,
			widgets.systray(),
			sep,
			widgets.wifi("wlan0"),
			spacer,
			widgets.cpu(),
			spacer,
			widgets.ram(),
			spacer,
			widgets.ssd(),
			spacer,
			widgets.pulseaudio_sink(),
			sep,
		}, right)
	else
		right = gears.table.join({ spacer }, right)
	end

	local bar = awful.wibar({ position = "top", screen = screen })
	bar:setup({
		{
			left,
			halign = "left",
			widget = wibox.container.place,
		},
		{
			middle,
			widget = wibox.container.place,
		},
		{
			right,
			halign = "right",
			widget = wibox.container.place,
		},
		layout = wibox.layout.flex.horizontal,
	})
end)
