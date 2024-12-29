return {
	"Wansmer/treesj",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		use_default_keymaps = false,
	},
	keys = {
		{
			"<C-s>",
			function()
				require("treesj").split()
			end,
			desc = "Split lines",
		},
		{
			"<C-j>",
			function()
				require("treesj").join()
			end,
			desc = "Join lines",
		},
	},
}
