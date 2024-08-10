local awful = require("awful")
local gears = require("gears")
local fn = require("util.fn")

local targets = { sink = "@DEFAULT_SINK@", source = "@DEFAULT_SOURCE@" }
local object = gears.object()

local function refresh(name)
	local get_mute_cmd = string.format("pactl get-%s-mute %s", name, targets[name])
	local get_volume_cmd = string.format("pactl get-%s-volume %s", name, targets[name])

	awful.spawn.easy_async(get_mute_cmd, function(mute)
		if mute:match("yes") then
			object:emit_signal(name .. "::mute", true)
			return
		end

		awful.spawn.easy_async(get_volume_cmd, function(volume)
			object:emit_signal(name .. "::volume", tonumber(volume:match("(%d+)%%")))
		end)
	end)
end

local function set_volume(name, value)
	local set_volume_cmd = string.format("pactl set-%s-volume %s %s", name, targets[name], value)
	awful.spawn.easy_async(set_volume_cmd, fn.bind(refresh, name))
end

local function set_mute(name, value)
	local set_mute_cmd = string.format("pactl set-%s-mute %s %s", name, targets[name], value)
	awful.spawn.easy_async(set_mute_cmd, fn.bind(refresh, name))
end

local function connect_signal(name, func)
	object:connect_signal(name, function(_, value)
		func(value)
	end)
end

return {
	refresh_sink_volume = function()
		refresh("sink")
	end,
	refresh_source_volume = function()
		refresh("source")
	end,
	set_sink_volume = function(value)
		set_volume("sink", value)
	end,
	set_source_volume = function(value)
		set_volume("source", value)
	end,
	set_sink_mute = function(value)
		set_mute("sink", value)
	end,
	set_source_mute = function(value)
		set_mute("source", value)
	end,
	connect_signal = function(name, func)
		connect_signal(name, func)
	end,
}
