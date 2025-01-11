local gears = require("gears")
local async = require("util.async")
local json = require("util.json")
local string_util = require("util.string")

local PA = gears.object()

function PA:set_sink_volume(name, value)
	return self:set_volume({ type = "sink", name = name, value = value })
end

function PA:get_sink_volume(name)
	return self:get_volume("sink", name)
end

function PA:get_sink_mute(name)
	return self:get_mute("sink", name)
end

function PA:set_sink_mute(opts)
	return self:set_mute({ type = "sink", name = opts.name, value = opts.value })
end

function PA:set_source_volume(opts)
	return self:set_volume({ type = "source", name = opts.name, value = opts.value })
end

function PA:set_source_mute(opts)
	return self:set_mute({ type = "source", name = opts.name, value = opts.value })
end

function PA:get_source_mute(name)
	return self:get_mute("source", name)
end

function PA:set_volume(opts)
	opts = opts or {}
	if opts.name == nil then
		opts.name = opts.type == "sink" and "@DEFAULT_SINK@" or "@DEFAULT_SOURCE@"
	end

	local unmute_cmd = string.format("pactl set-%s-mute %s no", opts.type, opts.name)
	local set_volume_cmd = string.format("pactl set-%s-volume %s %s", opts.type, opts.name, opts.value)
	return async
		.spawn(unmute_cmd)
		:next(function()
			return async.spawn(set_volume_cmd)
		end)
		:next(function()
			return self:get_volume(opts.type, opts.name)
		end)
		:next(function(volume)
			if volume > 100 then
				return self:set_volume({ type = opts.type, name = opts.name, value = "100%" })
			end

			if not opts.silent then
				self:emit_signal(opts.type .. "::volume", opts.name, volume)
			end

			return volume
		end)
end

function PA:set_mute(opts)
	opts = opts or {}
	if opts.name == nil then
		opts.name = opts.type == "sink" and "@DEFAULT_SINK@" or "@DEFAULT_SOURCE@"
	end
	local cmd = string.format("pactl set-%s-mute %s %s", opts.type, opts.name, opts.value)
	return async
		.spawn(cmd)
		:next(function()
			return self:get_mute(opts.type, opts.name)
		end)
		:next(function(mute)
			if mute then
				return 0
			end
			return self:get_volume(opts.type, opts.name)
		end)
		:next(function(volume)
			if not opts.silent then
				self:emit_signal(opts.type .. "::volume", opts.name, volume)
			end
			return volume
		end)
end

function PA:get_volume(type, name)
	local cmd = string.format("pactl get-%s-volume %s", type, name)
	return async.spawn(cmd):next(function(result)
		return tonumber(result.stdout:match("(%d+)%%"))
	end)
end

function PA:get_mute(type, name)
	local cmd = string.format("pactl get-%s-mute %s", type, name)
	return async.spawn(cmd):next(function(result)
		return result.stdout:match("yes")
	end)
end

function PA:list_sinks()
	return self:list("sink")
end

function PA:list_sources()
	return self:list("source")
end

function PA:list(type)
	return self:get_default(type):next(function(default)
		local cmd = string.format("pactl --format json list %ss", type)
		return async.spawn(cmd):next(function(result)
			local items = {}
			for _, item in ipairs(json.decode(result.stdout)) do
				if item.properties["device.class"] == "sound" then
					local channels = string_util.split(item.channel_map, ",")
					local volume = item.volume[channels[1]].value_percent:gsub("%%", "")
					table.insert(items, {
						type = type,
						index = item.index,
						name = item.name,
						description = item.description,
						volume = tonumber(volume),
						mute = item.mute,
						is_default = item.name == default,
						icon = item.properties["device.icon_name"],
					})
				end
			end
			return items
		end)
	end)
end

function PA:set_default_sink(name)
	return self:set_default("sink", name)
end

function PA:set_default_source(name)
	return self:set_default("source", name)
end

function PA:set_default(type, name)
	local cmd = string.format("pactl set-default-%s %s", type, name)
	return async.spawn(cmd)
end

function PA:get_default_sink()
	return self:get_default("sink")
end

function PA:get_default_source()
	return self:get_default("source")
end

function PA:get_default(type)
	local cmd = string.format("pactl get-default-%s", type)
	return async.spawn(cmd):next(function(result)
		return result.stdout:gsub("\n", "")
	end)
end

return PA
