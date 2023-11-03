return {
	'catppuccin/nvim',
	name = 'catppuccin',
	opts = {
		flavour = 'macchiato',
		no_bold = true,
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
			neotree = true,
			neotest = true,
			mason = true,
			notify = true,
		},
		custom_highlights = function(colors)
			return {
				-- Native
				Pmenu = { bg = colors.crust },
				SpellBad = { sp = colors.green },
				TextYank = { fg = colors.yellow, bg = colors.none, reverse = true },
				VertSplit = { fg = colors.surface0 },
				NormalFloat = { bg = colors.base },
				WinBar = { fg = colors.text },

				-- NvimTree
				NvimTreeNormal = { bg = colors.base },
				NvimTreeWinSeparator = { link = 'VertSplit' },

				-- Neo-tree
				NeoTreeNormal = { bg = colors.base },
				NeoTreeNormalNC = { bg = colors.base },

				-- Telescope
				TelescopeTitle = { reverse = true },

				-- Lualine
				LualineExoticFileFormat = { fg = colors.red, bg = colors.mantle },
				LualineGitSignsAdd = { fg = colors.green, bg = colors.mantle },
				LualineGitSignsChange = { fg = colors.yellow, bg = colors.mantle },
				LualineGitSignsDelete = { fg = colors.red, bg = colors.mantle },
				LualineWinbar = { bg = colors.base },
				LualineWinbarInactive = { fg = colors.overlay0, bg = colors.base },
				LualineLspActive = { fg = colors.green, bg = colors.mantle },
				LualineCopilotActive = { fg = colors.blue, bg = colors.mantle },

				-- Cokeline
				CokelineFocused = { fg = colors.blue },
				CokelineFocusedModified = { fg = colors.blue },
				CokelineModified = { fg = colors.peach },
				CokelineUnfocused = { fg = colors.text },
				CokelineSidebarFocused = { fg = colors.blue },
				CokelineSidebarUnfocused = { fg = colors.text },

				-- Dressing
				FloatTitle = { fg = colors.blue, reverse = true },

				-- Lightbulb
				LightBulbSign = { fg = colors.yellow },

				-- Flash
				FlashLabel = { fg = colors.crust, bg = colors.peach },
			}
		end,
	},
	config = function(_, opts)
		require('catppuccin').setup(opts)
		vim.cmd.colorscheme('catppuccin')
	end,
}
