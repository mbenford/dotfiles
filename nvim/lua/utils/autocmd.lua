local M = {}

function M.augroup(name)
	local group = vim.api.nvim_create_augroup(name, { clear = true })
	return function(event, opts)
		opts['group'] = group
		vim.api.nvim_create_autocmd(event, opts)
	end
end

function M.autocmd(event, opts)
	local group = vim.api.nvim_create_augroup('user_cmds', { clear = false })
	opts['group'] = group
	vim.api.nvim_create_autocmd(event, opts)
end

return M
