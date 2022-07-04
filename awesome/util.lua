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

return M
