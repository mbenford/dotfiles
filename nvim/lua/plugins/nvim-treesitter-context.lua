require('treesitter-context').setup({
	max_lines = 1,
})

vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'CursorLine' })
