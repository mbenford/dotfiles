local null_ls = require('null-ls')
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
	sources = {
		-- diagnostics
		diagnostics.flake8,
		diagnostics.staticcheck,

		-- formatting
		formatting.autopep8,
		formatting.goimports,
		formatting.stylua,

		-- code actions
		-- code_actions.gitsigns,
	},
})
