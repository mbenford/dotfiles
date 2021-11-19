local M = {lua_funcs = {}}

local function map(mode, args)
	local opts = {noremap = true, silent = true}
	for k, v in pairs(args) do
		if type(k) == 'string' then opts[k] = v end
	end

	local keymap, action = args[1], args[2]
	if type(action) == 'function' then
		table.insert(M.lua_funcs, action)
		action = string.format([[<cmd>lua require'map'.lua_funcs[%s]()<cr>]], #M.lua_funcs)
	end

	vim.api.nvim_set_keymap(mode, keymap, action, opts)
end

function M.n(args)
	map('n', args)
end

function M.v(args)
	map('v', args)
end

function M.x(args)
	map('x', args)
end

function M.c(args)
	map('c', args)
end

return M
