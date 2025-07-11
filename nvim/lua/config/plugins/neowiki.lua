return {
	"echaya/neowiki.nvim",
	opts = {
		wiki_dirs = {
			{ name = "Work", path = "~/notes/Work" },
			{ name = "Personal", path = "~/notes/Personal" },
		},
		keymaps = {
			action_link = "<Leader>n<Space>",
		},
	},
	keys = {
		{
			"<Leader>nn",
			function()
				require("neowiki").open_wiki()
			end,
			desc = "Open Notes",
		},
		{
			"<Leader>nN",
			function()
				require("neowiki").open_wiki_floating()
			end,
			desc = "Open Floating Notes",
		},
	},
}
