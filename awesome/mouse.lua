local awful = require("awful")
local ez = require("util.ez")

awful.mouse.append_client_mousebindings(ez.buttons({
	["1"] = function(c)
		c:activate({ context = "mouse_click" })
	end,
	["M-1"] = function(c)
		c:activate({ context = "mouse_click", action = "mouse_move" })
	end,
	["M-3"] = function(c)
		c:activate({ context = "mouse_click", action = "mouse_resize" })
	end,
}))
