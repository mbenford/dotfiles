local M = {
	'utilyre/barbecue.nvim',
	name = 'barbecue',
	enabled = false,
	dependencies = {
		'SmiteshP/nvim-navic',
		'nvim-tree/nvim-web-devicons',
	},
}

function M.config()
	require('barbecue').setup({
		show_modified = true,
		show_navic = false,
		show_dirname = false,
		custom_section = function(bufnr)
			return table.concat({
				M.diagnostic(bufnr),
			}, ' ')
		end,
	})
	vim.api.nvim_create_autocmd({ 'DiagnosticChanged' }, {
		group = vim.api.nvim_create_augroup('barbecue.diagnostic', {}),
		callback = function()
			require('barbecue.ui').update()
		end,
	})
end

function M.diagnostic(bufnr)
	if vim.api.nvim_get_mode().mode:sub(1, 1) == 'i' then
		return ''
	end

	local count = { 0, 0, 0, 0 }
	for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
		count[diagnostic.severity] = count[diagnostic.severity] + 1
	end

	local severity = vim.diagnostic.severity
	local result = {}

	if count[severity.ERROR] > 0 then
		table.insert(result, M.diagnostic_label('Error', 'E', count[severity.ERROR]))
	end
	if count[severity.WARN] > 0 then
		table.insert(result, M.diagnostic_label('Warn', 'W', count[severity.WARN]))
	end
	if count[severity.INFO] > 0 then
		table.insert(result, M.diagnostic_label('Info', 'I', count[severity.INFO]))
	end
	if count[severity.HINT] > 0 then
		table.insert(result, M.diagnostic_label('Hint', 'H', count[severity.HINT]))
	end

	return table.concat(result, ' ')
end

function M.diagnostic_label(severity, text, count)
	local sign = vim.fn.sign_getdefined('DiagnosticSign' .. severity)
	if #sign == 0 then
		return text .. ':' .. count
	end

	return '%#' .. sign[1]['texthl'] .. '#' .. sign[1]['text'] .. count
end

return M
