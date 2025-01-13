return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		expand = 5,
		triggers = {
			{ "<auto>", mode = "no" },
		},
		delay = function(ctx)
			return ctx.plugin and 0 or 1000
		end,
		filter = function(mapping)
			return mapping.desc and mapping.desc ~= ""
		end,
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
