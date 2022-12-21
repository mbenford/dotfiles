local sign_define = vim.fn.sign_define
sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
sign_define('DiagnosticSignHint', { text = '硫', texthl = 'DiagnosticSignHint' })

vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
	update_in_insert = false,

	float = {
		scope = 'line',
		focusable = false,
		severity_sort = true,
		source = 'always',
		border = require('utils.ui').border_float,
		header = '',
		prefix = '',
		format = function(diagnostic)
			if diagnostic.code then
				return string.format('%s (%s)', diagnostic.message, diagnostic.code)
			end
			return diagnostic.message
		end,
	},
})

local lazy = require('legendary.toolbox').lazy
require('legendary').keymaps({
	{ '<Leader>k', vim.diagnostic.open_float, description = 'Open diagnostic window for current line' },
	{ '[d', vim.diagnostic.goto_prev, description = 'Go to previous diagnostic' },
	{ ']d', vim.diagnostic.goto_next, description = 'Go to next diagnostic' },
	{
		'[e',
		lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }),
		description = 'Go to previous diagnostic error',
	},
	{
		']e',
		lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }),
		description = 'Go to next diagnostic error',
	},
})
