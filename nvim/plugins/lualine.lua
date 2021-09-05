require('lualine').setup{
	options = {
		theme = 'dracula',
	},
	sections = {
		lualine_x = {'filetype'},
		lualine_y = {'encoding', 'fileformat'},
	},
	extensions = {'nvim-tree', 'fzf'},
}
