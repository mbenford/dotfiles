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

local hl = require('utils.highlight')
local colors = require('onedark.colors')
hl.set('GitSignsChange', { guifg = colors.orange, guibg = 'none' })
hl.set('GitSignsAddLn', { guibg = colors.bg1 })
hl.set('GitSignsChangeLn', { guibg = colors.bg1 })
hl.set('GitSignsDeleteLn', { guibg = colors.bg1 })
