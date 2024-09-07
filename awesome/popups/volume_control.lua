local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local widgets = require("widgets")
local fn = require("util.fn")
local ez = require("util.ez")
local popup_util = require("util.popup")
local pulseaudio = require("util.pulseaudio")
local icons = require("icons")

local sinks = widgets.list({})
local popup = awful.popup({
	widget = sinks,
})

return {
	show = function() end,
}
