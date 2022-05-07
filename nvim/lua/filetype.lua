vim.filetype.add({
	extension = {
		pcss = 'pcss',
	},
})

require('nvim-treesitter.parsers').filetype_to_parsername.pcss = 'scss'
