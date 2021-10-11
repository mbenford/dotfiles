local function lsp_clients()
	local clients = {}
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		table.insert(clients, client.name)
	end
	if #clients > 0 then
		return ' ' .. table.concat(clients, ' ')
	end
	return ''
end

local function line_ending()
	local formats = {dos='CRLF', unix='LF'}
	return formats[vim.bo.fileformat]
end

local function encoding()
	if vim.bo.fenc ~= '' then
		return string.upper(vim.bo.fenc)
	end
	return string.upper(vim.o.enc)
end

require'lualine'.setup{
	options = {
		theme = 'onedark',
		section_separators = {left = '', right = ''},
		component_separators = {left = '|', right = '|'},
	},
	sections = {
		lualine_b = {
		},
		lualine_c = {
			{'filename', path = 1, symbols = {modified = '', readonly = ' '}},
		},
		lualine_x = {
			{
				'diagnostics',
				sources = {'nvim_lsp'},
				symbols = {error = ' ', warn = ' ', hint = ' ', info = ' '}
			},
			lsp_clients,
			encoding,
			line_ending,
			{'branch', icon = ''},
		},
		lualine_y = {
		},
		lualine_z = {
			'location',
		},
	},
	extensions = {'nvim-tree', 'quickfix'},
}
