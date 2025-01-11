return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufRead", "BufWritePost" },
	opts = {
		max_lines = 2,
	},
}
