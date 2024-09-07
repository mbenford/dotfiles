local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")

local api = { screen = screen }

api.screen.connect_signal("request::desktop_decoration", function(screen)
	for i = 1, 4 do
		awful.tag.add(i, {
			screen = screen,
			layout = awful.layout.suit.tile,
			enable_padding = true,
		})
	end
	screen.tags[1]:view_only()

	local padding = widgets.util.spacer(10)
	local spacer = widgets.util.spacer(10)
	local sep = widgets.util.sep(15)

	local left = {
		layout = wibox.layout.fixed.horizontal,
		padding,
		widgets.taglist(screen),
		spacer,
		widgets.layout(screen),
		spacer,
		widgets.window.count(screen),
		spacer,
	}
	local middle = {
		layout = wibox.layout.fixed.horizontal,
		widgets.window.title(screen),
	}
	local right = {
		layout = wibox.layout.fixed.horizontal,
		widgets.clock(),
		padding,
	}

	if screen == api.screen.primary then
		right = gears.table.join({
			spacer,
			widgets.hardware.cpu(),
			spacer,
			widgets.hardware.mem(),
			spacer,
			widgets.hardware.ssd(),
			sep,
			widgets.wifi("wlan0"),
			spacer,
			widgets.pulseaudio.sink_icon(),
			spacer,
			widgets.notification(),
			spacer,
		}, right)
	end

	screen.bar = awful.wibar({ position = "top", screen = screen })
	screen.bar:setup({
		layout = wibox.layout.flex.horizontal,
		{
			widget = wibox.container.place,
			halign = "left",
			left,
		},
		{
			widget = wibox.container.place,
			halign = "center",
			middle,
		},
		{
			widget = wibox.container.place,
			halign = "right",
			right,
		},
	})
end)
