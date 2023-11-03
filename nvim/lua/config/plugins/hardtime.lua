return {
	'm4xshen/hardtime.nvim',
	dependencies = {
		'MunifTanjim/nui.nvim',
		'nvim-lua/plenary.nvim',
	},
	opts = {
		max_count = 3,
		allow_different_key = true,
		disabled_filetypes = { 'lazy', 'qf', 'mason', 'neo-tree' },
		disabled_keys = {
			['<Up>'] = {},
			['<Down>'] = {},
			['<Left>'] = {},
			['<Right>'] = {},
		},
	},
}
