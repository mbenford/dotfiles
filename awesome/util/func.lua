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

function M.lazy(func, ...)
	local args = { ... }
	return function()
		func(table.unpack(args))
	end
end

function M.client_func(func)
	return function()
		if client.focus then
			func(client.focus)
		end
	end
end

function M.tag_func(func)
	return function()
		local tag = awful.screen.focused().selected_tag
		if tag then
			func(tag)
		end
	end
end

function M.split(str, sep)
	if str == nil or str == "" then
		return ""
	end

	local items = {}
	for item in str:gmatch("([^" .. sep .. "]+)") do
		table.insert(items, item)
	end
	return items
end

return M
