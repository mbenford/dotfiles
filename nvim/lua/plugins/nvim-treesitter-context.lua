require('treesitter-context').setup({
	max_lines = 1,
})

local hl = require('utils.highlight')
hl.link({ 'TreesitterContext', 'CursorLine' })
