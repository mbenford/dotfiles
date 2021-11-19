local colors = require'onedark.colors'
local theme = {
	normal = {
		a = {fg = colors.bg0, bg = colors.green, gui = 'bold'},
		b = {fg = colors.fg, bg = colors.bg3},
		c = {fg = colors.fg, bg = colors.bg_d},
	},
	visual = {
		a = {fg = colors.bg0, bg = colors.purple, gui = 'bold'},
	},
	replace = {
		a = {fg = colors.bg0, bg = colors.red, gui = 'bold'},
	},
	insert = {
		a = {fg = colors.bg0, bg = colors.blue, gui = 'bold'},
	},
	command = {
		a = {fg = colors.bg0, bg = colors.yellow, gui = 'bold'},
	},
	inactive = {
		a = {fg = colors.fg, bg = colors.bg_d, gui = 'bold'},
		b = {fg = colors.fg, bg = colors.bg_d},
		c = {fg = colors.fg, bg = colors.bg_d},
	},
}

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
		theme = theme,
		section_separators = {left = '', right = ''},
		component_separators = {left = '', right = ''},
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
	inactive_sections = {
		lualine_a = {},
		lualine_b = {
			{'filename', path = 1},
		},
		lualine_c = {},
	},
	extensions = {'nvim-tree', 'quickfix'},
}
