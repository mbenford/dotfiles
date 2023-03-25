local sign = vim.fn.sign_define
sign('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
sign('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
sign('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
sign('DiagnosticSignHint', { text = '硫', texthl = 'DiagnosticSignHint' })

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
