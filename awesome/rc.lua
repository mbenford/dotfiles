-- If LuaRocks is installed, make sure that packages installed through it
-- are found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Dirty hack to disable naughty so dunst can be loaded
-- https://github.com/awesomeWM/awesome/issues/1285
-- package.loaded["naughty.dbus"] = {}

-- Basic keybindings
local awful = require("awful")
awful.keyboard.append_global_keybindings({
	awful.key({ "Mod4", "Control" }, "r", awesome.restart),
	awful.key({ "Mod4", "Control" }, "q", awesome.quit),
	awful.key({ "Mod4", "Control" }, "Return", function()
		awful.spawn("kitty", {
			floating = true,
			ontop = true,
			fullscreen = true,
			placement = awful.placement.centered,
		})
	end),
})

local function load(module)
	local success, error = pcall(require, module)
	if not success then
		require("naughty").notification({
			urgency = "critical",
			title = string.format("Error while loading module '%s'", module),
			app_name = "AwesomeWM",
			app_icon = "dialog-error",
			message = error,
		})
	end
end

load("theme")
load("keys")
load("signals")
load("bar")
load("mouse")
load("rules")
load("popups")
load("scratchpads")
load("awful.autofocus")
load("autorun")
