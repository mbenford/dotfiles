vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
	update_in_insert = false,

	float = {
		scope = 'cursor',
		source = 'always',
		severity_sort = true,
	},
})

local map = require'map'
map.n{'<leader>ge', '<cmd>lua vim.diagnostic.goto_next()<cr>'}
map.n{'<leader>ve', '<cmd>lua vim.diagnostic.open_float()<cr>'}
