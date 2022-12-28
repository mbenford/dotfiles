return {
	'romgrk/nvim-treesitter-context',
	event = { 'BufRead', 'BufWritePost' },
	config = function()
		require('treesitter-context').setup({
			max_lines = 1,
		})
		local hl = require('utils.highlight')
		hl.set('TreesitterContext', { link = 'CursorLine' })
	end,
}
