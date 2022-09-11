local awful = require("awful")
local naughty = require("naughty")

local capi = { tag = tag }

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)

capi.tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.max,
	})
end)

local function set_padding(t)
	local static_clients = 0
	for _, client in ipairs(t:clients()) do
		if not client.floating then
			static_clients = static_clients + 1
		end
	end

	if static_clients > 1 and t.layout ~= awful.layout.suit.max then
		t.screen.padding = { left = 0, right = 0 }
		return
	end

	if t.screen.geometry.width <= 1920 then
		t.screen.padding = { left = 0, right = 0 }
		return
	end

	local padding = t.screen.geometry.width - 1920
	t.screen.padding = { left = padding / 2, right = padding / 2 }
end

capi.tag.connect_signal("tagged", set_padding)
capi.tag.connect_signal("untagged", set_padding)
capi.tag.connect_signal("cleared", set_padding)
capi.tag.connect_signal("property::selected", set_padding)
capi.tag.connect_signal("property::layout", set_padding)

