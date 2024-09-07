local api = { awesome = awesome, screen = screen, client = client, tag = tag, mouse = mouse }
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		app_name = "AwesomeWM",
		app_icon = "dialog-error",
		message = message,
	})
end)

api.client.connect_signal("property::urgent", function(c)
	if c.urgent then
		c:jump_to()
		c:swap(awful.client.getmaster())
	end
end)

api.client.connect_signal("focus", function(c)
	if api.mouse.current_client ~= c then
		require("util.mouse").move_to_client(c)
	end
end)

api.tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.max,
		awful.layout.suit.fair,
	})
end)

local min_screen_width = 1920
local function fix_screen_padding(tag)
	if tag == nil then
		return
	end

	local screen = tag.screen
	if tag.screen == nil then
		return
	end
	screen.padding = { left = 0, right = 0 }

	if screen.geometry.width <= min_screen_width or not tag.enable_padding then
		return
	end

	local clients_count = 0
	for _, client in ipairs(tag:clients()) do
		if not client.floating and not client.minimized then
			clients_count = clients_count + 1
		end
	end

	if clients_count == 1 or tag.layout == awful.layout.suit.max then
		local padding = screen.geometry.width - min_screen_width
		screen.padding = { left = padding / 2, right = padding / 2 }
	end
end

api.tag.connect_signal("tagged", fix_screen_padding)
api.tag.connect_signal("untagged", fix_screen_padding)
api.tag.connect_signal("cleared", fix_screen_padding)
api.tag.connect_signal("property::selected", fix_screen_padding)
api.tag.connect_signal("property::layout", fix_screen_padding)
api.tag.connect_signal("property::enable_padding", fix_screen_padding)
api.client.connect_signal("property::minimized", function(c)
	fix_screen_padding(c.first_tag)
end)

api.client.connect_signal("request::titlebars", function(c)
	local titlebar = awful.titlebar(c, { size = beautiful.titlebar_size })
	titlebar.widget = {
		{
			halign = "center",
			font = beautiful.titlebar_font,
			widget = awful.titlebar.widget.titlewidget(c),
		},
		layout = wibox.layout.flex.horizontal,
	}
end)
