require('gitsigns').setup({
	signs = {
		add = { text = '▋' },
		change = { text = '▋' },
		delete = { text = '▁' },
		topdelete = { text = '▔' },
		changedelete = { text = '▋' },
	},
	keymaps = {},
	preview_config = {
		border = require('utils.ui').border_float,
	},
	on_attach = function ()
		local bmap = require('utils.map').bmap
		local gitsigns = require('gitsigns')
		bmap('n', '<leader>gp', gitsigns.preview_hunk)
		bmap('n', '<leader>gr', gitsigns.reset_hunk)
		bmap('n', '<leader>gn', gitsigns.next_hunk)
		bmap('n', '<leader>gN', gitsigns.prev_hunk)
		bmap('n', '<leader>gB', gitsigns.blame_line)
	end
})


local hl = require('utils.highlight')
hl.add({ 'GitSignsChange', guifg = require('onedark.colors').orange, guibg = 'none' })
