return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = false,
	event = { "BufRead", "InsertEnter" },
	main = "ibl",
	opts = {
		exclude = { filetypes = { "man", "help", "qf" } },
		indent = {
			char = "▏",
			tab_char = "▏",
		},
		scope = {
			enabled = false,
			show_start = false,
		},
	},
}
