return {
	"folke/flash.nvim",
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
	keys = {
		{
			"<CR>",
			function()
				require("flash").jump({
					label = {
						min_pattern_length = 2,
					},
				})
			end,
			mode = { "n", "x", "o" },
			desc = "Flash (Jump)",
		},
		{
			"<Leader>v",
			function()
				require("flash").treesitter()
			end,
			mode = { "n", "x", "o" },
			desc = "Flash (Select)",
		},
		{
			"r",
			function()
				require("flash").remote()
			end,
			mode = "o",
			desc = "Flash (Remote)",
		},
		{
			"gl",
			function()
				require("flash").jump({
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
			desc = "Flash (Jump to line)",
		},
		{ "f", "F", "t", "T" },
	},
}
