return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	lazy = true,
	event = "User DapLoaded",
	opts = {
		automatic_installation = true,
		ensure_installed = {
			"delve",
		},
		handlers = {
			function(config)
				config = require("config.dap")(config)
				require("mason-nvim-dap").default_setup(config)
			end,
		},
	},
}
