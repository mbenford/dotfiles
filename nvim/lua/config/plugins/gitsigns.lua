return {
	'lewis6991/gitsigns.nvim',
	event = 'BufRead',
	opts = {
		signs = {
			changedelete = { text = '┃' },
			untracked = { text = '┃' },
		},
		preview_config = {
			border = require('utils.ui').border_float,
		},
		on_attach = function()
			local gitsigns = require('gitsigns')
			require('legendary').keymaps({
				{ '<leader>gp', gitsigns.preview_hunk, opts = { buffer = true }, description = '' },
				{ '<leader>gr', gitsigns.reset_hunk, opts = { buffer = true }, description = '' },
				{ '<leader>gn', gitsigns.next_hunk, opts = { buffer = true }, description = '' },
				{ '<leader>gN', gitsigns.prev_hunk, opts = { buffer = true }, description = '' },
				{ '<leader>gB', gitsigns.blame_line, opts = { buffer = true }, description = '' },
			})
		end,
	},
}
