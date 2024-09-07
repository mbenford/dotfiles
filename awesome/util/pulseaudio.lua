local gears = require("gears")
local async = require("util.async")

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

function PA:get_sink_volume()
	return self:get_volume("sink")
end

function PA:get_sink_mute()
	return self:get_mute("sink")
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

function PA:set_volume(name, value)
	local unmute_cmd = string.format("pactl set-%s-mute %s no", name, targets[name])
	local set_volume_cmd = string.format("pactl set-%s-volume %s %s", name, targets[name], value)
	return async
		.spawn(unmute_cmd)
		:next(function()
			return async.spawn(set_volume_cmd)
		end)
		:next(function()
			return self:get_volume(name)
		end)
		:next(function(volume)
			if volume > 100 then
				return self:set_volume(name, "100%")
			end
			self:emit_signal(name .. "::volume", volume)
			return volume
		end)
end

function PA:set_mute(name, value)
	local set_mute_cmd = string.format("pactl set-%s-mute %s %s", name, targets[name], value)
	return async
		.spawn(set_mute_cmd)
		:next(function()
			return self:get_mute(name)
		end)
		:next(function(mute)
			if mute then
				return 0
			end
			return self:get_volume(name)
		end)
		:next(function(volume)
			self:emit_signal(name .. "::volume", volume)
		end)
end

function PA:get_volume(name)
	local get_volume_cmd = string.format("pactl get-%s-volume %s", name, targets[name])
	return async.spawn(get_volume_cmd):next(function(result)
		return tonumber(result.stdout:match("(%d+)%%"))
	end)
end

function PA:get_mute(name)
	local get_mute_cmd = string.format("pactl get-%s-mute %s", name, targets[name])
	return async.spawn(get_mute_cmd):next(function(result)
		return result.stdout:match("yes")
	end)
end

return PA
