return {
	"catppuccin/nvim",
	name = "catppuccin",
	enabled = false,
	opts = {
		flavour = "macchiato",
		no_bold = true,
		no_italic = true,
		integrations = {
			native_lsp = {
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
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
				FloatBorder = { bg = colors.base },
				WinBar = { fg = colors.text },

				-- NvimTree
				NvimTreeNormal = { bg = colors.base },
				NvimTreeWinSeparator = { link = "VertSplit" },

				-- Neo-tree
				NeoTreeNormal = { bg = colors.base },
				NeoTreeNormalNC = { bg = colors.base },

				-- StatusLine
				StatusLineFilenameModified = { fg = colors.yellow, bg = colors.mantle },
				StatusLineExoticFileFormat = { fg = colors.red, bg = colors.mantle },
				StatusLineGitSignsAdd = { fg = colors.green, bg = colors.mantle },
				StatusLineGitSignsChange = { fg = colors.yellow, bg = colors.mantle },
				StatusLineGitSignsDelete = { fg = colors.red, bg = colors.mantle },
				StatusLineWinbar = { bg = colors.base },
				StatusLineWinbarInactive = { fg = colors.overlay0, bg = colors.base },
				StatusLineLspActive = { fg = colors.green, bg = colors.mantle },
				StatusLineCopilotActive = { fg = colors.blue, bg = colors.mantle },
				StatusLineRecording = { fg = colors.red, bg = colors.mantle },
				StatusLineGitStatusClean = { fg = colors.green, bg = colors.mantle },
				StatusLineGitStatusDirty = { fg = colors.yellow, bg = colors.mantle },

				-- Cokeline
				CokelineFocused = { fg = colors.blue },
				CokelineFocusedModified = { fg = colors.blue },
				CokelineModified = { fg = colors.peach },
				CokelineUnfocused = { fg = colors.text },
				CokelineSidebarFocused = { fg = colors.blue },
				CokelineSidebarUnfocused = { fg = colors.text },

				-- Lightbulb
				LightBulbSign = { fg = colors.yellow },

				-- Flash
				FlashLabel = { fg = colors.crust, bg = colors.peach },

				-- Noice
				NoiceCmdline = { bg = colors.mantle },

				-- Treesitter Context
				TreesitterContext = { link = "CursorLine" },
				TreesitterContextLineNumber = { link = "CursorLine" },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
