return {
	"folke/trouble.nvim",
	event = "BufRead",
	opts = {
		use_diagnostic_signs = true,
		focus = true,
	},
	keys = {
		{
			"<Leader>tt",
			function()
				require("trouble").open("todo")
			end,
			desc = "Trouble (todo)",
		},
		{
			"<Leader>td",
			function()
				require("trouble").open("diagnostics")
			end,
			desc = "Trouble (diagnostics)",
		},
	},
}
