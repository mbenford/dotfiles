local null_ls = require'null-ls'
null_ls.setup({
	sources = {
		-- diagnostics
		null_ls.builtins.diagnostics.eslint.with({
			command = './node_modules/.bin/eslint',
		}),
		null_ls.builtins.diagnostics.flake8,

		-- formatting
		null_ls.builtins.formatting.autopep8,

		-- code actions
		null_ls.builtins.code_actions.eslint.with({
			command = './node_modules/.bin/eslint',
		}),
	}
})
