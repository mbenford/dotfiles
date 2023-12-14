return {
	"Wansmer/treesj",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	event = "BufRead",
	opts = {
		use_default_keymaps = false,
	},
	config = function(_, opts)
		local treesj = require("treesj")
		treesj.setup(opts)

		require("legendary").keymaps({
			{ "<C-s>", treesj.split, description = "" },
			{ "<C-j>", treesj.join, description = "" },
		})
	end,
}
