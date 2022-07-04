local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local widgets = require("widgets")
local constants = require("constants")

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(constants.tags, s, awful.layout.suit.tile)

	local padding = widgets.spacer(5)
	local spacer = widgets.spacer(10)
	local sep = widgets.sep(15)

	local left = {
		padding,
		widgets.taglist(s),
		spacer,
		widgets.layoutbox(s),
		sep,
		layout = wibox.layout.fixed.horizontal,
	}
	local middle = {
		widgets.tasklist(s),
		layout = wibox.layout.fixed.horizontal,
	}
	local right = {
		sep,
		widgets.clock(),
		padding,
		layout = wibox.layout.fixed.horizontal,
	}

	if s == screen.primary then
		right = gears.table.join({
			sep,
			widgets.cpu(),
			spacer,
			widgets.memory(),
			spacer,
			widgets.disk(),
			spacer,
			widgets.packages(),
			spacer,
			widgets.volume(),
			sep,
			wibox.widget.systray(),
		}, right)
	end

	local bar = awful.wibar({ position = "top", screen = s })
	bar:setup({ left, middle, right, layout = wibox.layout.align.horizontal })
end)
