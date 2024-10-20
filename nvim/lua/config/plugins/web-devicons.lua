return {
	"nvim-tree/nvim-web-devicons",
	enabled = false,
	lazy = true,
	opts = {
		default = true,
		strict = true,
		override = {
			css = {
				icon = "",
				color = "#264de4",
				name = "CSS",
			},
			scss = {
				icon = "",
				color = "#264de4",
				name = "SASS",
			},
			pcss = {
				icon = "",
				color = "#264de4",
				name = "PostCSS",
			},
		},
		override_by_filename = {
			["go.mod"] = {
				icon = "",
				color = "#519aba",
				name = "GoMod",
			},
			["go.sum"] = {
				icon = "",
				color = "#519aba",
				name = "GoSum",
			},
		},
	},
}
