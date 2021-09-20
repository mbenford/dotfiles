local M = {}

function M.map(args)
	local opts = {noremap = true, silent = true}
	for k, v in pairs(args) do
		if type(k) == 'string' then opts[k] = v end
	end
	local buffer = opts.buffer
	opts.buffer = nil

	if buffer then
		vim.api.nvim_buf_set_keymap(0, args[1], args[2], args[3], opts)
	else
		vim.api.nvim_set_keymap(args[1], args[2], args[3], opts)
	end
end

return M
