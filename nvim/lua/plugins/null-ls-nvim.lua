local null_ls = require('null-ls')
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	sources = {
		-- diagnostics
		diagnostics.eslint_d.with({
			extra_args = { '--parser-options=codeFrame:false' },
		}),
		diagnostics.flake8,
		diagnostics.staticcheck,

		-- formatting
		formatting.eslint_d,
		formatting.autopep8,
		formatting.goimports,
		formatting.stylua,

		-- code actions
		code_actions.eslint_d,
	},
})
