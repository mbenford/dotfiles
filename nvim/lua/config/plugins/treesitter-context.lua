return {
	'romgrk/nvim-treesitter-context',
	enabled = false,
	event = { 'BufRead', 'BufWritePost' },
	config = function()
		require('treesitter-context').setup({
			max_lines = 1,
			line_numbers = false,
		})
		local hl = require('utils.highlight')
		hl.set('TreesitterContext', { link = 'CursorLine' })
	end,
}
