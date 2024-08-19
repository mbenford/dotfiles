local awful = require("awful")
local gears = require("gears")
local fn = require("util.fn")

local targets = { sink = "@DEFAULT_SINK@", source = "@DEFAULT_SOURCE@" }
local PA = gears.object()

function PA:refresh_sink_volume()
	self:refresh("sink")
end

function PA:refresh_source_volume()
	self:refresh("source")
end

function PA:set_sink_volume(value)
	self:set_volume("sink", value)
end

function PA:get_sink_volume(cb)
	self:get_volume("sink", cb)
end

function PA:get_sink_mute(cb)
	self:get_mute("sink", cb)
end

function PA:set_source_volume(value)
	self:set_volume("source", value)
end

function PA:set_sink_mute(value)
	self:set_mute("sink", value)
end

function PA:set_source_mute(value)
	self:set_mute("source", value)
end

function PA:refresh(name)
	self:get_mute(name, function(mute)
		if mute then
			self:emit_signal(name .. "::mute", true)
			return
		end

		self:get_volume(name, function(volume)
			self:emit_signal(name .. "::volume", volume)
		end)
	end)
end

function PA:set_volume(name, value)
	local set_volume_cmd = string.format("pactl set-%s-volume %s %s", name, targets[name], value)
	awful.spawn.easy_async(set_volume_cmd, fn.bind_obj(self, "refresh", name))
end

function PA:set_mute(name, value)
	local set_mute_cmd = string.format("pactl set-%s-mute %s %s", name, targets[name], value)
	awful.spawn.easy_async(set_mute_cmd, fn.bind_obj(self, "refresh", name))
end

function PA:get_volume(name, cb)
	local get_volume_cmd = string.format("pactl get-%s-volume %s", name, targets[name])
	awful.spawn.easy_async(get_volume_cmd, function(volume)
		cb(tonumber(volume:match("(%d+)%%")))
	end)
end

function PA:get_mute(name, cb)
	local get_mute_cmd = string.format("pactl get-%s-mute %s", name, targets[name])
	awful.spawn.easy_async(get_mute_cmd, function(mute)
		cb(mute:match("yes"))
	end)
end

return PA
