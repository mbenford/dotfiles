-- If LuaRocks is installed, make sure that packages installed through it
-- are found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Dirty hack to disable naughty so dunst can be loaded
-- https://github.com/awesomeWM/awesome/issues/1285
package.loaded["naughty.dbus"] = {}

require("awful.autofocus")
require("signals")
require("theme")
require("bar")
require("keys")
require("mouse")
require("rules")
require("autorun")
