return {
	"williamboman/mason.nvim",
	event = { "BufRead", "BufWritePost" },
	opts = {
		ui = {
			icons = {
				package_installed = " ",
				package_pending = "󰇚",
				package_uninstalled = " ",
			},
		},
	},
}
