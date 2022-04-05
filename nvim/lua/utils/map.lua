local function map(modes, keymap, command, opts)
	opts = vim.tbl_deep_extend('force', { noremap = true, silent = true }, opts or {})
	opts['desc'] = nil

	if type(command) == 'function' then
		command = require('utils.function').register(command, { as_cmd = true })
	end

	for _, mode in pairs(modes) do
		if opts.buffer == nil then
			vim.api.nvim_set_keymap(mode, keymap, command, opts)
		else
			opts.buffer = nil
			vim.api.nvim_buf_set_keymap(0, mode, keymap, command, opts)
		end
	end
end

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
	map(split(modes), keymap, command, opts)
end

function M.bmap(modes, keymap, command, opts)
	opts = opts or {}
	opts['buffer'] = true
	M.map(modes, keymap, command, opts)
end

return M
