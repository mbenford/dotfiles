return {
	'nvim-lualine/lualine.nvim',
	config = function()
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

		local function lsp_status()
			local clients = vim.lsp.buf_get_clients()
			return #clients > 0 and '%#LualineLspStatus# LSP' or ''
		end

		local function filetype()
			return vim.bo.filetype
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

		local function diagnostic_symbol(name, default)
			local symbol = vim.fn.sign_getdefined(name)
			return #symbol == 0 and default or symbol[1]['text']
		end

		require('lualine').setup({
			options = {
				theme = 'catppuccin',
				globalstatus = true,
				icons_enabled = true,
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },
				disabled_filetypes = {
					'packer',
					'lspinfo',
					'startuptime',
					'TelescopePrompt',
					'Trouble',
					'DressingInput',
					winbar = {
						'NvimTree',
						'toggleterm',
					},
				},
				ignore_focus = {
					'NvimTree',
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
				lualine_c = {
					{ 'branch', icon = '' },
					gitsigns_status,
				},
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
					{ lsp_status },
					{ filetype, fmt = string.upper },
					{ indentation, fmt = string.upper },
					{ 'encoding', fmt = string.upper },
					{ file_format, fmt = string.upper },
					location,
				},
				-- empty sections
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
			},
			-- winbar = {
			-- 	lualine_c = {
			-- 		{
			-- 			'filename',
			-- 			color = 'LualineWinbar',
			-- 		},
			-- 	},
			-- 	lualine_x = {
			-- 	},
			-- },
			-- inactive_winbar = {
			-- 	lualine_c = {
			-- 		{
			-- 			'filename',
			-- 			color = 'LualineWinbarInactive',
			-- 		},
			-- 	},
			-- },
			extensions = {
				'nvim-tree',
				'quickfix',
				'nvim-dap-ui',
				'toggleterm',
			},
		})
	end,
}
