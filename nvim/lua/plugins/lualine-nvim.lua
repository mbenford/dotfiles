local colors = require('onedark.colors')
local theme = {
	normal = {
		a = { fg = colors.bg0, bg = colors.green, gui = 'bold' },
		b = { fg = colors.fg, bg = colors.bg_d },
		c = { fg = colors.fg, bg = colors.bg_d },
		x = { fg = colors.fg, bg = colors.bg_d },
		y = { fg = colors.fg, bg = colors.bg_d },
		z = { fg = colors.fg, bg = colors.bg_d },
	},
	visual = {
		a = { fg = colors.bg0, bg = colors.purple, gui = 'bold' },
		z = { fg = colors.fg, bg = colors.bg_d },
	},
	replace = {
		a = { fg = colors.bg0, bg = colors.red, gui = 'bold' },
		z = { fg = colors.fg, bg = colors.bg_d },
	},
	insert = {
		a = { fg = colors.bg0, bg = colors.blue, gui = 'bold' },
		z = { fg = colors.fg, bg = colors.bg_d },
	},
	command = {
		a = { fg = colors.bg0, bg = colors.yellow, gui = 'bold' },
		z = { fg = colors.fg, bg = colors.bg_d },
	},
	inactive = {
		a = { fg = colors.grey, bg = colors.bg_d },
		b = { fg = colors.grey, bg = colors.bg_d },
		c = { fg = colors.grey, bg = colors.bg_d },
	},
}

local function gitsigns_status()
	local status = vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict')
	local result = {}

	if status['added'] > 0 then
		table.insert(result, '%#LualineGitSignsAdd#+' .. status['added'])
	end
	if status['changed'] > 0 then
		table.insert(result, '%#LualineGitSignsChange#~' .. status['changed'])
	end
	if status['removed'] > 0 then
		table.insert(result, '%#LualineGitSignsDelete#-' .. status['removed'])
	end

	return table.concat(result, ' ')
end

local function lsp_clients()
	local clients = vim.lsp.buf_get_clients()
	if #clients > 0 then
		return string.format('LSP:%s', #clients)
	end
	return ''
end

local function indentation()
	local size = vim.bo.shiftwidth
	if vim.bo.expandtab then
		return 'SPC:' .. size
	end
	return 'TAB:' .. size
end

local function file_format()
	if vim.bo.fileformat ~= 'unix' then
		return '%#LualineExoticFileFormat#' .. vim.bo.fileformat
	end
	return ''
end

local function location()
	return '%2l:%-2v'
end

local function diagnostic_symbol(name, default)
	local symbol = vim.fn.sign_getdefined(name)
	return #symbol == 0 and default or symbol[1]['text']
end

require('lualine').setup({
	options = {
		theme = theme,
		globalstatus = true,
		icons_enabled = false,
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		disabled_filetypes = {
			'packer',
			'lspinfo',
			'lsp-installer',
			'startuptime',
			'TelescopePrompt',
			'Trouble',
			'DressingInput',
		},
	},
	sections = {
		lualine_a = {
			{
				'mode',
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = {
			'branch',
			{ gitsigns_status, padding = { left = 0, right = 1 } },
			'lsp_progress',
		},
		lualine_c = {},
		lualine_x = {
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = {
					error = diagnostic_symbol('DiagnosticSignError', 'E:'),
					warn = diagnostic_symbol('DiagnosticSignWarn', 'W:'),
					info = diagnostic_symbol('DiagnosticSignInfo', 'I:'),
					hint = diagnostic_symbol('DiagnosticSignHint', 'H:'),
				},
			},
			{ lsp_clients, color = { fg = colors.blue } },
		},
		lualine_y = {
			{ 'filetype', fmt = string.upper },
			indentation,
			{ 'encoding', fmt = string.upper },
			{ file_format, fmt = string.upper },
		},
		lualine_z = {
			location,
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {
			{ 'filename', path = 0 },
		},
		lualine_c = {},
	},
	extensions = { 'nvim-tree', 'quickfix' },
})

local set_hl = vim.api.nvim_set_hl
set_hl(0, 'LualineExoticFileFormat', { fg = colors.red, bg = theme.normal.c.bg })
set_hl(0, 'LualineExoticFileFormat', { fg = colors.red, bg = theme.normal.c.bg })
set_hl(0, 'LualineGitSignsAdd', { fg = colors.green, bg = theme.normal.c.bg })
set_hl(0, 'LualineGitSignsChange', { fg = colors.orange, bg = theme.normal.c.bg })
set_hl(0, 'LualineGitSignsDelete', { fg = colors.red, bg = theme.normal.c.bg })
