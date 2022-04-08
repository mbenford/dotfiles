local function split(modes)
	if modes == '' then
		return {''}
	end

	local result = {}
	for m in modes:gmatch('.') do
		table.insert(result, m)
	end
	return result
end

local M = {}

function M.map(modes, keymap, command, opts)
	opts = vim.tbl_deep_extend('force', { silent = true }, opts or {})
	vim.keymap.set(split(modes), keymap, command, opts)
end

function M.bmap(modes, keymap, command, opts)
	opts = opts or {}
	opts['buffer'] = true
	M.map(modes, keymap, command, opts)
end

return M
