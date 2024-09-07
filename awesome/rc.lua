-- If LuaRocks is installed, make sure that packages installed through it
-- are found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Dirty hack to disable naughty so dunst can be loaded
-- https://github.com/awesomeWM/awesome/issues/1285
-- package.loaded["naughty.dbus"] = {}

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

load("awful.autofocus")
load("signals")
load("theme")
load("bar")
load("keys")
load("mouse")
load("rules")
load("popups")
load("scratchpads")
load("autorun")
