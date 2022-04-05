vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
	update_in_insert = false,

	float = {
		scope = 'line',
		focusable = false,
		severity_sort = true,
		source = 'always',
		border = require('utils.ui').border_float,
		header = '',
		prefix = '',
		format = function(diagnostic)
			if diagnostic.code then
				return string.format('%s (%s)', diagnostic.message, diagnostic.code)
			end
			return diagnostic.message
		end,
	},
})

local map = require('utils.map').map
map('n', '<leader>ge', vim.diagnostic.goto_next)
map('n', '<leader>ve', vim.diagnostic.open_float)
