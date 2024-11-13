return {
	"Wansmer/treesj",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	event = "BufRead",
	opts = {
		use_default_keymaps = false,
	},
	keys = {
		{
			"<C-s>",
			function()
				require("treesj").split()
			end,
			desc = "",
		},
		{
			"<C-j>",
			function()
				require("treesj").join()
			end,
			desc = "",
		},
	},
}
