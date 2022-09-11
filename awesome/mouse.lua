local awful = require("awful")
local ezbuttons = require("util.ez").ezbuttons

awful.mouse.append_client_mousebindings(ezbuttons({
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
