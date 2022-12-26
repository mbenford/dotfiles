return {
	'jose-elias-alvarez/null-ls.nvim',
	event = 'BufRead',
	config = function()
		local null_ls = require('null-ls')
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting
		local code_actions = null_ls.builtins.code_actions

		null_ls.setup({
			sources = {
				diagnostics.flake8,
				-- diagnostics.staticcheck,

				formatting.goimports,
				formatting.autopep8,
				formatting.stylua,

				code_actions.refactoring,
			},
			on_attach = require('lsp').on_attach,
		})
	end,
}
