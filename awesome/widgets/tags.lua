local api = { client = client, tag = tag }
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")
local tag = require("util.tag")

return {
	list = function(screen)
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

		return awful.widget.taglist({
			screen = screen,
			filter = awful.widget.taglist.filter.all,
			layout = {
				layout = wibox.layout.fixed.horizontal,
				spacing = 3,
			},
			widget_template = templates[beautiful.taglist_style],
		})
	end,
	client_list = function(screen)
		return awful.widget.tasklist({
			screen = screen,
			filter = awful.widget.tasklist.filter.currenttags,
			widget_template = {
				id = "background_role",
				widget = wibox.container.background,
				{
					layout = wibox.layout.align.horizontal,
					{
						widget = wibox.container.margin,
						left = 5,
						right = 5,
						{
							widget = wibox.container.place,
							valign = true,
							{
								widget = wibox.widget.imagebox,
								id = "icon_role",
							},
						},
					},
					{
						widget = wibox.container.margin,
						right = 5,
						{
							widget = wibox.widget.textbox,
							id = "text_role",
						},
					},
				},
			},
		})
	end,
	layout_icon = function(screen)
		local layout_icons = {
			tile = "view_quilt",
			max = "capture",
			fairv = "view_module",
		}

		local icon = wibox.widget({
			widget = icons.material.icon,
			size = 28,
			name = layout_icons[screen.selected_tag.layout.name],
			fg = "#ffffff",
		})

		api.tag.connect_signal("property::layout", function(tag)
			if tag.screen == screen then
				icon.name = layout_icons[tag.layout.name]
			end
		end)

		return icon
	end,
	layout_name = function(screen)
		local name = wibox.widget({
			widget = wibox.widget.textbox,
			font = "JetBrains Mono 10",
			text = "tile",
		})

		return name
	end,
	window_title = function(screen)
		local content = wibox.widget.textbox()
		content.font = beautiful.window_name_font

		local function update_title(c)
			if not c.floating and c.screen == screen and api.client.focus == c then
				content.text = c.name
			end
		end
		local function clear_title(t)
			if t.screen == screen and #tag.tiled_clients(t) == 0 then
				content.text = ""
			end
		end

		api.client.connect_signal("focus", update_title)
		api.client.connect_signal("property::name", update_title)
		api.tag.connect_signal("untagged", clear_title)
		api.tag.connect_signal("property::selected", clear_title)

		return wibox.widget({
			widget = wibox.container.background,
			fg = beautiful.window_name_fg,
			bg = beautiful.window_name_bg,
			{
				widget = wibox.container.margin,
				content,
			},
		})
	end,

	window_count = function(screen)
		local content = icons.material.icon()
		content.size = 22
		content.fill = true
		content.fg = "#ffffff"

		local function update_count(t)
			if t.screen == screen then
				content.name = "counter_" .. #tag.tiled_clients(t)
			end
		end

		api.tag.connect_signal("tagged", update_count)
		api.tag.connect_signal("untagged", update_count)
		api.tag.connect_signal("cleared", update_count)
		api.tag.connect_signal("property::selected", update_count)
		api.tag.connect_signal("property::layout", update_count)

		return wibox.widget({
			widget = wibox.container.background,
			fg = beautiful.window_count_fg,
			bg = beautiful.window_count_bg,
			{
				widget = wibox.container.margin,
				content,
			},
		})
	end,
}
