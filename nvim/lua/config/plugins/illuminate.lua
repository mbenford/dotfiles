return {
	"RRethy/vim-illuminate",
	event = { "BufRead", "BufWritePost" },
	opts = {
		modes_allowlist = { "n" },
		filetypes_denylist = {
			"qf",
			"oil",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
	end,
}
