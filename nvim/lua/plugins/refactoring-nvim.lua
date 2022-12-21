require('refactoring').setup({
	prompt_func_return_type = {
		go = true,
	},
	prompt_func_param_type = {
		go = true,
	},
})

vim.api.nvim_set_keymap(
	'v',
	'<leader>rr',
	":lua require('refactoring').select_refactor()<CR>",
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>rp',
	":lua require('refactoring').debug.printf({below = false})<CR>",
	{ noremap = true }
)
