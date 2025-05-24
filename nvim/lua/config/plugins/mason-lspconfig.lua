return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	event = { "BufRead", "InsertEnter" },
	opts = {
		automatic_installation = true,
		ensure_installed = {
			"basedpyright",
			"bashls",
			"cssls",
			"cssmodules_ls",
			"dockerls",
			"eslint",
			"gopls",
			"html",
			"jsonls",
			"lua_ls",
			"rust_analyzer",
			"terraformls",
			"ts_ls",
			"yamlls",
		},
		handlers = {
			function(server_name)
				local server = require("lspconfig")[server_name]
				local config = require("config.lsp")(server_name)
				server.setup(config)
			end,
		},
	},
}
