return {
	'nvim-treesitter/nvim-treesitter-context',
	enabled = false,
	event = { 'BufRead', 'BufWritePost' },
	opts = {
		max_lines = 2,
	},
}
