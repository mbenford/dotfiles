return {
	"cbochs/grapple.nvim",
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
			desc = "Open Grapple",
		},
		{
			"<Leader>ha",
			function()
				require("grapple").tag()
			end,
			desc = "Add Grapple tag",
		},
		{
			"<Leader>hd",
			function()
				require("grapple").untag()
			end,
			desc = "Delete Grapple tag",
		},
		{
			"<Leader>hc",
			function()
				require("grapple").reset()
			end,
			desc = "Clear all Grapple tags",
		},
		{
			"<Leader>1",
			function()
				require("grapple").select({ index = 1 })
			end,
			desc = "Select Grapple tag 1",
		},
		{
			"<Leader>2",
			function()
				require("grapple").select({ index = 2 })
			end,
			desc = "Select Grapple tag 2",
		},
		{
			"<Leader>3",
			function()
				require("grapple").select({ index = 3 })
			end,
			desc = "Select Grapple tag 3",
		},
		{
			"<Leader>4",
			function()
				require("grapple").select({ index = 4 })
			end,
			desc = "Select Grapple tag 4",
		},
	},
}
