vim.diagnostic.config({
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
		},
	},
	virtual_text = {
		spacing = 0,
		prefix = " ",
		suffix = " ",
		severity = vim.diagnostic.severity.ERROR,
	},
	float = {
		scope = "line",
		focusable = false,
		severity_sort = true,
		source = true,
		border = "rounded",
		header = "",
		prefix = "",
	},
})
