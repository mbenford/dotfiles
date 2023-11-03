return {
	'lewis6991/gitsigns.nvim',
	event = 'BufRead',
	opts = {
		signs = {
			add = { text = '▍' },
			change = { text = '▍' },
			delete = { text = '▍' },
			topdelete = { text = '▍' },
			changedelete = { text = '▍' },
			untracked = { text = '▍' },
		},
		preview_config = {
			border = 'rounded',
		},
		on_attach = function()
			local gitsigns = require('gitsigns')
			require('legendary').keymaps({
				{ '<leader>gp', gitsigns.preview_hunk, opts = { buffer = true }, description = '' },
				{ '<leader>gr', gitsigns.reset_hunk, opts = { buffer = true }, description = '' },
				{ '<leader>gB', gitsigns.blame_line, opts = { buffer = true }, description = '' },
				{ ']g', gitsigns.next_hunk, opts = { buffer = true }, description = '' },
				{ '[g', gitsigns.prev_hunk, opts = { buffer = true }, description = '' },
			})
		end,
	},
}
