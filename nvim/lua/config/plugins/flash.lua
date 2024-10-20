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
				"<CR>",
				lazy(flash.jump, {
					label = {
						min_pattern_length = 2,
					},
				}),
				mode = { "n", "x", "o" },
				description = "Flash",
			},
			{ "<Leader>v", flash.treesitter, mode = { "n", "x", "o" }, description = "Flash" },
			{ "r", flash.remote, mode = { "o" }, description = "Flash (Remote)" },
			{
				"gl",
				function()
					flash.jump({
						search = { mode = "search", max_length = 0 },
						label = { after = { 0, 0 } },
						highlight = { matches = false },
						pattern = "^",
						action = function(match, state)
							local is_operator = vim.fn.mode(true):find("no")
							require("flash.jump").jump(match, state)
							if is_operator then
								vim.cmd.normal("V")
							end
						end,
					})
				end,
				mode = { "n", "x", "o" },
				description = "Flash (Jump to line)",
			},
		})
	end,
}
