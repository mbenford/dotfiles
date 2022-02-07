local M = {}

function M.bind(fn, ...)
	local args = {...}
	return function()
		return fn(unpack(args))
	end
end

return M
