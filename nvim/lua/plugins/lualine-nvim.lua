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

local function null_ls_sources()
	local sources = {}
	local active_sources = require'null-ls.info'.get_active_sources()
	for _, source in pairs(active_sources[require'null-ls'.methods.DIAGNOSTICS]) do
		table.insert(sources, source)
	end
	return table.concat(sources, ',')
end

local function lsp_clients()
	local clients = {}
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		if client.name == 'null-ls' then
			table.insert(clients, null_ls_sources())
		else
			table.insert(clients, client.name)
		end
	end
	if #clients > 0 then
		return table.concat(clients, ' ')
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

local function indentation()
	local size = vim.bo.shiftwidth
	if vim.bo.expandtab then
		return 'SPC:' .. size
	end
	return 'TAB:' .. size
end

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

local hl = require'highlight'
hl.add{'LualineGitSignsAdd', guifg=colors.green, guibg=theme.normal.c.bg}
hl.add{'LualineGitSignsChange', guifg=colors.orange, guibg=theme.normal.c.bg}
hl.add{'LualineGitSignsDelete', guifg=colors.red, guibg=theme.normal.c.bg}

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
		},
		lualine_c = {
			{'branch', icon = ''},
			{gitsigns_status, padding = {left = 0, right = 1}},
		},
		lualine_x = {
			{
				'diagnostics',
				sources = {'nvim_diagnostic'},
				symbols = {error = ' ', warn = ' ', hint = ' ', info = ' '}
			},
			{ lsp_clients, color = {fg = colors.blue}},
			{'filetype', colored = false},
			encoding,
			line_ending,
			indentation,
			'location',
		},
		lualine_y = {
		},
		lualine_z = {
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
