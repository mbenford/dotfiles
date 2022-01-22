vim.g.kommentary_create_default_mappings = false
require('kommentary.config').configure_language('default', {
	prefer_single_line_comments = true,
})

local map = require('utils.map')
map.n({ '<leader>c', '<Plug>kommentary_line_default', noremap = false })
map.x({ '<leader>c', '<Plug>kommentary_visual_default<C-c>', noremap = false })
