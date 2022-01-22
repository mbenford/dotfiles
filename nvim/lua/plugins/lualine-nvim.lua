local colors = require'onedark.colors'
local theme = {
	normal = {
		a = {fg = colors.bg0, bg = colors.green, gui = 'bold'},
		b = {fg = colors.fg, bg = colors.bg_d},
		c = {fg = colors.fg, bg = colors.bg_d},
		x = {fg = colors.fg, bg = colors.bg_d},
		y = {fg = colors.fg, bg = colors.bg_d},
		z = {fg = colors.fg, bg = colors.bg_d},
	},
	visual = {
		a = {fg = colors.bg0, bg = colors.purple, gui = 'bold'},
		z = {fg = colors.fg, bg = colors.bg_d},
	},
	replace = {
		a = {fg = colors.bg0, bg = colors.red, gui = 'bold'},
		z = {fg = colors.fg, bg = colors.bg_d},
	},
	insert = {
		a = {fg = colors.bg0, bg = colors.blue, gui = 'bold'},
		z = {fg = colors.fg, bg = colors.bg_d},
	},
	command = {
		a = {fg = colors.bg0, bg = colors.yellow, gui = 'bold'},
		z = {fg = colors.fg, bg = colors.bg_d},
	},
	inactive = {
		a = {fg = colors.grey, bg = colors.bg_d},
		b = {fg = colors.grey, bg = colors.bg_d},
		c = {fg = colors.grey, bg = colors.bg_d},
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
		return string.format('  %s', #clients)
	end
	return ''
end

local function indentation()
	local size = vim.bo.shiftwidth
	if vim.bo.expandtab then
		return 'spaces:' .. size
	end
	return 'tabs:' .. size
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

local hl = require'utils.highlight'
hl.add{'LualineExoticFileFormat', guifg = colors.red, guibg = theme.normal.c.bg}
hl.add{'LualineGitSignsAdd', guifg = colors.green, guibg = theme.normal.c.bg}
hl.add{'LualineGitSignsChange', guifg = colors.orange, guibg = theme.normal.c.bg}
hl.add{'LualineGitSignsDelete', guifg = colors.red, guibg = theme.normal.c.bg}

require'lualine'.setup{
	options = {
		theme = theme,
		section_separators = {left = '', right = ''},
		component_separators = {left = '', right = ''},
	},
	sections = {
		lualine_a = {
			{'mode', fmt = function(str) return str:sub(1,1) end},
		},
		lualine_b = {
			{'branch', icon = ''},
			{gitsigns_status, padding = {left = 0, right = 1}},
		},
		lualine_c = {
		},
		lualine_x = {
			{
				'diagnostics',
				sources = {'nvim_diagnostic'},
				symbols = {error = ' ', warn = ' ', info = ' ', hint = '硫'},
			},
			{lsp_clients, color = {fg = colors.blue}},
		},
		lualine_y = {
			{'filetype', colored = false},
			indentation,
			'encoding',
			file_format
		},
		lualine_z = {
			location,
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {
			{'filename', path = 0},
		},
		lualine_c = {},
	},
	extensions = {'nvim-tree', 'quickfix'},
}
