return {
	'catppuccin/nvim',
	name = 'catppuccin',
	opts = {
		flavour = 'macchiato',
		no_italic = true,
		integrations = {
			native_lsp = {
				underlines = {
					errors = { 'undercurl' },
					hints = { 'undercurl' },
					warnings = { 'undercurl' },
					information = { 'undercurl' },
				},
			},
			dap = {
				enabled = true,
				enable_ui = true,
			},
			navic = {
				enabled = true,
			},
		},
		custom_highlights = function(colors)
			return {
				-- Native
				Pmenu = { bg = colors.crust },
				SpellBad = { sp = colors.green },
				TextYank = { fg = colors.yellow, bg = colors.none, reverse = true },
				VertSplit = { fg = colors.surface0 },
				NormalFloat = { bg = colors.base },

				-- NvimTree
				NvimTreeNormal = { bg = colors.base },
				NvimTreeWinSeparator = { link = 'VertSplit' },

				-- Telescope
				TelescopeTitle = { reverse = true },

				-- Lualine
				LualineExoticFileFormat = { fg = colors.red, bg = colors.mantle },
				LualineGitSignsAdd = { fg = colors.green, bg = colors.mantle },
				LualineGitSignsChange = { fg = colors.yellow, bg = colors.mantle },
				LualineGitSignsDelete = { fg = colors.red, bg = colors.mantle },
				LualineLspStatus = { fg = colors.blue, bg = colors.mantle },
				LualineWinbar = { bg = colors.base },
				LualineWinbarInactive = { fg = colors.overlay0, bg = colors.base },

				-- Cokeline
				CokelineFocused = { fg = colors.blue },
				CokelineFocusedModified = { fg = colors.blue },
				CokelineModified = { fg = colors.peach },
				CokelineUnfocused = { fg = colors.text },
				CokelineSidebarFocused = { fg = colors.blue },
				CokelineSidebarUnfocused = { fg = colors.text },

				-- Dressing
				FloatTitle = { fg = colors.blue, reverse = true },
			}
		end,
	},
	config = function(_, opts)
		require('catppuccin').setup(opts)
		vim.cmd.colorscheme('catppuccin')
	end,
}
