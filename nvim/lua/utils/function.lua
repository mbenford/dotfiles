local M = {}

local funcs = {}

function M.register(func, opts)
	opts = opts or { as_cmd = false }

	table.insert(funcs, func)
	local expr = string.format("lua require('utils.function').call(%s)", #funcs)
	if opts.as_cmd then
		return string.format('<cmd>%s<cr>', expr)
	end
	return expr
end

function M.call(id)
	funcs[id]()
end

function M.apply(fn, ...)
	local args = {...}
	return function()
		fn(unpack(args))
	end
end

function M.papply(fn, ...)
	local args = {...}
	return function()
		pcall(fn, unpack(args))
	end
end

return M
