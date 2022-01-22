require('indent_blankline').setup({
	char = '▏',
	use_treesitter = true,
	show_first_indent_level = false,
	max_indent_increase = 1,
	show_trailing_blankline_indent = false,
	filetype_exclude = { 'man', 'help', 'packer' },
	buftype_exclude = { 'nofile' },
})
