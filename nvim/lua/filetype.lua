vim.filetype.add({
	extension = {
		pcss = 'pcss',
		rasi = 'rasi',
	},
})

require('nvim-treesitter.parsers').filetype_to_parsername.pcss = 'scss'
