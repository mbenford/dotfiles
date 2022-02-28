local M = { lua_funcs = {} }

local function map(mode, keymap, action, opts)
	opts = vim.tbl_deep_extend('force', { noremap = true, silent = true }, opts or {})

	if type(action) == 'function' then
		table.insert(M.lua_funcs, action)
		action = string.format([[<cmd>lua require('utils.map').lua_funcs[%s]()<cr>]], #M.lua_funcs)
	end

	vim.api.nvim_set_keymap(mode, keymap, action, opts)
end

function M.n(keymap, action, opts)
	map('n', keymap, action, opts)
end

function M.v(keymap, action, opts)
	map('v', keymap, action, opts)
end

function M.x(keymap, action, opts)
	map('x', keymap, action, opts)
end

function M.c(keymap, action, opts)
	map('c', keymap, action, opts)
end

function M.o(keymap, action, opts)
	map('o', keymap, action, opts)
end

function M.i(keymap, action, opts)
	map('i', keymap, action, opts)
end

function M.t(keymap, action, opts)
	map('t', keymap, action, opts)
end

function M.a(keymap, action, opts)
	map('', keymap, action, opts)
end

return M
