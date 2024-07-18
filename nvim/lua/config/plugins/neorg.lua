return {
	"nvim-neorg/neorg",
	version = "*",
	ft = { "norg" },
	cmd = "Neorg",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
		},
	},
	config = function(_, opts)
		require("neorg").setup(opts)
	end,
}
