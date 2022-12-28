return {
	'lewis6991/gitsigns.nvim',
	event = 'BufRead',
	config = function ()
		require('gitsigns').setup({
			signs = {
				add = { text = '▋' },
				change = { text = '▋' },
				delete = { text = '▁' },
				topdelete = { text = '▔' },
				changedelete = { text = '▋' },
				untracked = { text = '▋' },
			},
			keymaps = {},
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
		})

		local hl = require('utils.highlight')
		local colors = require('onedark.colors')
		hl.set('GitSignsChange', { fg = colors.orange, bg = 'none' })
		hl.set('GitSignsAddLn', { bg = colors.bg1 })
		hl.set('GitSignsChangeLn', { bg = colors.bg1 })
		hl.set('GitSignsDeleteLn', { bg = colors.bg1 })
	end,
}
