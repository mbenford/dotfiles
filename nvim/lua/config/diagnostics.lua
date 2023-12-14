local sign = vim.fn.sign_define
sign('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
sign('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
sign('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
sign('DiagnosticSignHint', { text = '󰌶', texthl = 'DiagnosticSignHint' })

vim.diagnostic.config({
	update_in_insert = false,
	signs = false,
	underline = true,
	severity_sort = true,
	virtual_text = {
		spacing = 0,
		prefix = ' ',
		suffix = ' ',
		severity = vim.diagnostic.severity.ERROR,
	},
	float = {
		scope = 'line',
		focusable = false,
		severity_sort = true,
		source = 'always',
		border = 'rounded',
		header = '',
		prefix = '',
	},
})
