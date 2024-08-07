return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		prompt = { enabled = false },
		modes = {
			char = {
				keys = { "f", "F", "t", "T" },
				multi_line = false,
				jump_labels = true,
				highlight = { backdrop = false },
			},
			search = { enabled = false },
		},
		highlight = { backdrop = false },
	},
	config = function(_, opts)
		local flash = require("flash")
		flash.setup(opts)

		local lazy = require("legendary.toolbox").lazy
		require("legendary").keymaps({
			{
				"s",
				lazy(flash.jump, {
					label = {
						min_pattern_length = 2,
					},
				}),
				mode = { "n", "x", "o" },
				description = "Flash",
			},
			{ "S", flash.treesitter, mode = { "n", "x", "o" }, description = "Flash" },
			{ "r", flash.remote, mode = { "o" }, description = "Flash (Remote)" },
			{
				"gl",
				lazy(flash.jump, {
					search = { mode = "search", max_length = 0 },
					label = { after = { 0, 0 } },
					highlight = { matches = false },
					pattern = "^",
				}),
				mode = { "n", "x", "o" },
				description = "Flash (Jump to line)",
			},
		})
	end,
}
