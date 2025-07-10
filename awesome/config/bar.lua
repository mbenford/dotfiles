local api = { screen = screen }
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")

api.screen.connect_signal("request::desktop_decoration", function(screen)
	for i = 1, 3 do
		local name = string.format("%s%d", screen == api.screen.primary and "P" or "S", i)
		awful.tag.add(name, {
			screen = screen,
			layout = awful.layout.suit.tile,
			enable_padding = true,
		})
	end
	screen.tags[1]:view_only()

	local sections = {
		left = {
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			widgets.tags.list(screen),
			widgets.tags.layout_icon(screen),
			widgets.tags.window_count(screen),
		},
		middle = {
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			widgets.tags.window_title(screen),
		},
		right = {
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			widgets.clock(),
		},
	}

	if screen == api.screen.primary then
		sections.right = gears.table.join({
			-- widgets.systray(),
			widgets.hardware.cpu(),
			widgets.hardware.mem(),
			widgets.hardware.disk(),
			widgets.indicators(
				widgets.network.vpn("tun"),
				widgets.network.wifi("wlan0"),
				widgets.audio.sink_icon(),
				widgets.audio.source_icon(),
				widgets.hardware.battery(),
				widgets.notification()
			),
		}, sections.right)
	end

	screen.bar = awful.wibar({
		position = "top",
		screen = screen,
		widget = {
			widget = wibox.container.margin,
			margins = { left = 10, right = 10 },
			{
				layout = wibox.layout.flex.horizontal,
				{
					widget = wibox.container.place,
					halign = "left",
					sections.left,
				},
				{
					widget = wibox.container.place,
					halign = "center",
					sections.middle,
				},
				{
					widget = wibox.container.place,
					halign = "right",
					sections.right,
				},
			},
		},
	})
end)
