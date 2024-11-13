return {
	"cbochs/grapple.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		scope = "git",
		win_opts = {
			border = "rounded",
		},
	},
	keys = {
		{
			"<Leader>hh",
			function()
				require("grapple").open_tags()
			end,
			desc = "",
		},
		{
			"<Leader>ha",
			function()
				require("grapple").tag()
			end,
			desc = "",
		},
		{
			"<Leader>hd",
			function()
				require("grapple").untag()
			end,
			desc = "",
		},
		{
			"<Leader>hc",
			function()
				require("grapple").reset()
			end,
			desc = "",
		},
		{
			"<Leader>1",
			function()
				require("grapple").select({ index = 1 })
			end,
			desc = "",
		},
		{
			"<Leader>2",
			function()
				require("grapple").select({ index = 2 })
			end,
			desc = "",
		},
		{
			"<Leader>3",
			function()
				require("grapple").select({ index = 3 })
			end,
			desc = "",
		},
		{
			"<Leader>4",
			function()
				require("grapple").select({ index = 4 })
			end,
			desc = "",
		},
	},
}
