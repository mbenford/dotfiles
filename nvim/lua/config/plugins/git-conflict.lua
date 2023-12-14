return {
	"akinsho/git-conflict.nvim",
	tag = "v1.0.0",
	event = "BufRead",
	opts = {
		disable_diagnostics = true,
		default_mappings = {
			ours = "o",
			theirs = "t",
			none = "n",
			both = "b",
			prev = "[c",
			next = "]c",
		},
	},
}
