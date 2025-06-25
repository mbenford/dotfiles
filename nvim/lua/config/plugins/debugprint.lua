return {
	"andrewferrier/debugprint.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		highlight_lines = false,
		keymaps = {
			normal = {
				plain_below = "gpp",
				plain_above = "gpP",
				variable_below = "gpv",
				variable_above = "gpV",
				surround_plain = "gps",
				toggle_comment_debug_prints = "gpc",
				delete_debug_prints = "gpd",
				textobj_below = "",
				textobj_above = "",
				textobj_surround = "",
				surround_variable = "",
			},
			ivfhny = {
				variable_below = "gpp",
				variable_above = "gpP",
			},
		},
	},
	keys = { "gpp", "gpP", "gpv", "gpV", "gpc", "gpd" },
}
