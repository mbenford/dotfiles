local function current_working_dir()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

local function lsp_status()
	return #vim.lsp.get_active_clients() > 0 and '%#LualineLspActive# LSP' or ''
end

local function indentation()
	local size = vim.bo.shiftwidth
	return vim.bo.expandtab and ('SPC:' .. size) or ('TAB:' .. size)
end

local function file_format()
	return vim.bo.fileformat ~= 'unix' and ('%#LualineExoticFileFormat#' .. vim.bo.fileformat) or ''
end

local function location()
	return '%2l:%-2v'
end

return {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			theme = 'catppuccin',
			globalstatus = true,
			icons_enabled = true,
			section_separators = { left = '', right = '' },
			component_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = { 'TelescopePrompt' },
			},
		},
		sections = {
			lualine_a = {
				current_working_dir,
			},
			lualine_b = {},
			lualine_c = {
				{ 'branch', icon = '' },
			},
			lualine_x = {
				{ 'diagnostics', sources = { 'nvim_diagnostic' } },
				lsp_status,
				{ 'filetype', fmt = string.upper },
				{ indentation, fmt = string.upper },
				{ 'encoding', fmt = string.upper },
				{ file_format, fmt = string.upper },
				location,
			},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			'lazy',
			'neo-tree',
			'nvim-dap-ui',
			'quickfix',
			'trouble',
		},
	},
}
