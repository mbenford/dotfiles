local api = { client = client }
local awful = require("awful")

local M = {}

function M.map_threshold(value, thresholds)
	for _, t in ipairs(thresholds) do
		if value > t[1] then
			return t[2]
		end
	end
	return thresholds.normal
end

function M.span(color, format, ...)
	return string.format('<span foreground="%s">%s</span>', color, string.format(format, ...))
end

function M.bind(fn, ...)
	local left_args = { ... }
	return function(...)
		local args = { ... }
		return fn(table.unpack(require("gears").table.join(left_args, args)))
	end
end

function M.bind_right(fn, ...)
	local rightArgs = { ... }
	return function(...)
		local args = { ... }
		return fn(table.unpack(require("gears").table.join(args, rightArgs)))
	end
end

function M.bind_obj(obj, func, ...)
	local args = { ... }
	return function()
		obj[func](obj, table.unpack(args))
	end
end

function M.bind_require(mod, func, ...)
	local args = { ... }
	return function()
		require(mod)[func](table.unpack(args))
	end
end

function M.bind_client(fn)
	return function()
		if api.client.focus then
			fn(api.client.focus)
		end
	end
end

function M.bind_tag(fn)
	return function()
		local client = api.client.focus
		if client == nil then
			return
		end

		local tag = client.screen.selected_tag
		if tag then
			fn(tag, client)
		end
	end
end

return M
