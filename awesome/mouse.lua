local awful = require("awful")
local modkey = require("constants").modkey

awful.mouse.append_global_mousebindings({})
awful.mouse.append_client_mousebindings({
	awful.button({}, 1, function(c)
		c:activate({ context = "mouse_click" })
	end),
	awful.button({ modkey }, 1, function(c)
		c:activate({ context = "mouse_click", action = "mouse_move" })
	end),
	awful.button({ modkey }, 3, function(c)
		c:activate({ context = "mouse_click", action = "mouse_resize" })
	end),
})
