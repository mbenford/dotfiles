return {
	"jay-babu/mason-nvim-dap.nvim",
	cond = not vim.env.DEVPOD,
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	lazy = true,
	event = "User DapLoaded",
	opts = {
		automatic_installation = false,
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
