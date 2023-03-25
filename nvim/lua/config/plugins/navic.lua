return {
	'SmiteshP/nvim-navic',
	enabled = false,
	dependencies = {
		'neovim/nvim-lspconfig',
	},
	event = 'BufRead',
	opts = {
		highlight = true,
		separator = '  ',
		depth_limit = 3,
		icons = require('utils.ui').lsp_icons,
	},
}
