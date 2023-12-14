return {
	'folke/noice.nvim',
	event = 'VeryLazy',
	dependencies = {
		'MunifTanjim/nui.nvim',
		'rcarriga/nvim-notify',
	},
	opts = {
		lsp = {
			override = {
				['vim.lsp.util.convert_input_to_markdown_lines'] = true,
				['vim.lsp.util.stylize_markdown'] = true,
				['cmp.entry.get_documentation'] = true,
			},
		},
		presets = {
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
		cmdline = {
			view = 'cmdline',
		},
	},
}
