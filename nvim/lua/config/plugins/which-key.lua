return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- triggers = {},
		preset = "helix",
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
