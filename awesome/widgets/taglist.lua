local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local tag = require("util.tag")

local templates = {}
templates.standard = {
	layout = wibox.layout.align.vertical,
	nil,
	{
		widget = wibox.container.margin,
		top = 2,
		left = 6,
		right = 6,
		{
			widget = wibox.widget.textbox,
			id = "text_role",
		},
	},
	{
		widget = wibox.container.background,
		id = "background_role",
		forced_height = 2,
		wibox.widget.base.make_widget(),
	},
}
templates.circles = {
	layout = wibox.layout.align.horizontal,
	{
		widget = wibox.container.background,
		id = "background",
		{
			widget = wibox.container.margin,
			left = 3,
			right = 3,
			{
				widget = wibox.widget.textbox,
				id = "content",
				font = "Symbols Nerd Font 12",
			},
		},
	},
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
			if #tag.tiled_clients(t) > 0 then
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

return function(screen)
	return awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,
		layout = {
			layout = wibox.layout.fixed.horizontal,
			spacing = 3,
		},
		widget_template = templates[beautiful.taglist_style],
	})
end
