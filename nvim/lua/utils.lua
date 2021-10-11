local M = { keymap_funcs = {}}

function M.map(args)
	local opts = {noremap = true, silent = true}
	for k, v in pairs(args) do
		if type(k) == 'string' then opts[k] = v end
	end

	local modes, keymap, action = args[1], args[2], args[3]
	if type(action) == 'function' then
		table.insert(M.keymap_funcs, action)
		action = string.format([[:lua require'utils'.keymap_funcs[%s]()<cr>]], #M.keymap_funcs)
	end

	if type(modes) == 'string' then
		modes = {modes}
	end

	for _, mode in pairs(modes) do
		vim.api.nvim_set_keymap(mode, keymap, action, opts)
	end
end

return M
