return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm",
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
		},
		on_highlights = function(hl, colors)
			-- Native
			hl.Pmenu = { bg = colors.bg_highlight }
			hl.SpellBad = { undercurl = true, sp = colors.green }
			hl.TextYank = { fg = colors.yellow, bg = colors.none, reverse = true }
			hl.FloatTitle = { fg = colors.border_highlight, bg = colors.bg_float, reverse = true }

			-- LSP
			hl.LspInfoBorder = "FloatBorder"

			-- Telescope
			hl.TelescopeTitle = { reverse = true }
			hl.TelescopePromptTitle = { reverse = true }

			-- Treesitter Context
			hl.TreesitterContext = "CursorLine"

			-- Lualine
			hl.LualineFilenameModified = { fg = colors.yellow, bg = colors.bg_statusline }
			hl.LualineExoticFileFormat = { fg = colors.red, bg = colors.bg_statusline }
			hl.LualineLspActive = { fg = colors.green, bg = colors.bg_statusline }
			hl.LualineCopilotActive = { fg = colors.blue, bg = colors.bg_statusline }
			hl.LualineRecording = { fg = colors.red, bg = colors.bg_statusline }
			hl.LualineGitStatusClean = { fg = colors.green, bg = colors.bg_statusline }
			hl.LualineGitStatusDirty = { fg = colors.yellow, bg = colors.bg_statusline }
			hl.LualineGitBranch = { fg = colors.blue, bg = colors.bg_statusline }

			-- Noice
			hl.NoiceCmdline = { bg = colors.bg_statusline }

			-- GitSigns
			hl.GitSignsAdd = { fg = colors.green }
			hl.GitSignsChange = { fg = colors.yellow }
			hl.GitSignsDelete = { fg = colors.red }

			-- Quicker
			hl.QuickFixLineNr = "CursorLineNr"

			-- Better Quickfix
			hl.BqfPreviewFloat = "NormalFloat"
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight-storm")
	end,
}
