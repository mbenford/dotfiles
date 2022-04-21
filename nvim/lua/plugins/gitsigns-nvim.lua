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
	on_attach = function()
		local gitsigns = require('gitsigns')
		require('legendary').bind_keymaps({
			{ '<leader>gp', gitsigns.preview_hunk, opts = { buffer = true }, description = '' },
			{ '<leader>gr', gitsigns.reset_hunk, opts = { buffer = true }, description = '' },
			{ '<leader>gn', gitsigns.next_hunk, opts = { buffer = true }, description = '' },
			{ '<leader>gN', gitsigns.prev_hunk, opts = { buffer = true }, description = '' },
			{ '<leader>gB', gitsigns.blame_line, opts = { buffer = true }, description = '' },
		})
	end,
})

local set_hl = vim.api.nvim_set_hl
set_hl(0, 'GitSignsChange', { fg = require('onedark.colors').orange, bg = 'none' })
