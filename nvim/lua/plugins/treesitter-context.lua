return {
	'romgrk/nvim-treesitter-context',
	config = {
		max_lines = 1,
	},
	init = function()
		local hl = require('utils.highlight')
		hl.set('TreesitterContext', { link = 'CursorLine' })
	end,
}
