return {
	'ray-x/lsp_signature.nvim',
	event = 'BufRead',
	config = {
		hint_enable = false,
		fix_pos = true,
		handler_opts = {
			border = require('utils.ui').border_float,
		},
	},
}

