return {
	"nvim-mini/mini.diff",
	event = "BufRead",
	version = "*",
	opts = {
		view = {
			style = "sign",
			signs = {
				add = "▍",
				change = "▍",
				delete = "▍",
			},
		},
	},
	keys = {
		{
			"<Leader>gd",
			function()
				require("mini.diff").toggle_overlay(0)
			end,
			desc = "Toggle diff overlay",
		},
	},
}
