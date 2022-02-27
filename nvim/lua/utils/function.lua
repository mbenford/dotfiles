local M = {}

function M.bind(fn, ...)
	local args = {...}
	return function()
		return fn(unpack(args))
	end
end

function M.identity(...)
	return unpack({...})
end

return M
