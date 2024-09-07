local api = { client = client, tag = tag }
local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")
local tag = require("util.tag")

return {
	title = function(screen)
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

	count = function(screen)
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
			{
				content,
				widget = wibox.container.margin,
			},
			fg = beautiful.window_count_fg,
			bg = beautiful.window_count_bg,
			widget = wibox.container.background,
		})
	end,
}
