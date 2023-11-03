return {
	'stevearc/conform.nvim',
	event = { 'BufRead', 'InsertEnter' },
	opts = {
		formatters_by_ft = {
			css = { 'prettier' },
			go = { 'goimports' },
			html = { 'prettier' },
			javascript = { 'prettier' },
			javascriptreact = { 'prettier' },
			json = { 'prettier' },
			lua = { 'stylua' },
			markdown = { 'prettier' },
			python = { 'black' },
			rust = { 'rustfmt' },
			sh = { 'shfmt' },
			terraform = { 'terraform_fmt' },
			typescript = { 'prettier' },
			typescriptreact = { 'prettier' },
			['*'] = { 'trim_whitespace' },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		local conform = require('conform')
		conform.setup(opts)

		local legendary = require('legendary')
		legendary.keymaps({
			{ '<Leader><Leader>f', conform.format, description = '' },
		})
	end,
}
