return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "git",
		win_opts = {
			border = "rounded",
		},
	},
	init = function()
		require("which-key").add({
			{ "<Leader>h", group = "Grapple" },
		})
	end,
	keys = {
		{
			"<Leader>hh",
			function()
				require("grapple").open_tags()
			end,
			desc = "Open tags",
		},
		{
			"<Leader>ha",
			function()
				require("grapple").tag()
			end,
			desc = "Add tag",
		},
		{
			"<Leader>hd",
			function()
				require("grapple").untag()
			end,
			desc = "Delete tag",
		},
		{
			"<Leader>hc",
			function()
				require("grapple").reset()
			end,
			desc = "Clear all tags",
		},
		{
			"<Leader>1",
			function()
				require("grapple").select({ index = 1 })
			end,
			desc = "Select tag 1",
		},
		{
			"<Leader>2",
			function()
				require("grapple").select({ index = 2 })
			end,
			desc = "Select tag 2",
		},
		{
			"<Leader>3",
			function()
				require("grapple").select({ index = 3 })
			end,
			desc = "Select tag 3",
		},
		{
			"<Leader>4",
			function()
				require("grapple").select({ index = 4 })
			end,
			desc = "Select tag 4",
		},
	},
}
