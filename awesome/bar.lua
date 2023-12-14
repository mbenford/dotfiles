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
		widgets.distro(),
		sep,
		widgets.taglist(screen, "circles"),
		spacer,
		widgets.layoutbox(screen),
		spacer,
		layout = wibox.layout.fixed.horizontal,
	}
	local middle = {
		widgets.tasklist(screen),
		layout = wibox.layout.ratio.horizontal,
	}
	local right = {
		spacer,
		widgets.clock(),
		padding,
		layout = wibox.layout.fixed.horizontal,
	}

	if screen == api.screen.primary then
		right = gears.table.join({
			spacer,
			wibox.widget.systray(),
			spacer,
			widgets.cpu(),
			spacer,
			widgets.memory(),
			spacer,
			widgets.disk(),
		}, right)
	end

	local bar = awful.wibar({ position = "top", screen = screen })
	bar:setup({ left, middle, right, layout = wibox.layout.align.horizontal })
end)
