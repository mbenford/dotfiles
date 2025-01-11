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
			local darken = require("tokyonight.util").darken

			-- Native
			hl.Pmenu = { bg = colors.bg_highlight }
			hl.SpellBad = { undercurl = true, sp = colors.green }
			hl.TextYank = { fg = colors.yellow, bg = colors.none, reverse = true }
			hl.FloatTitle = { fg = colors.border_highlight, bg = colors.bg_float }
			hl.WinBar = "Normal"
			hl.WinBarNC = "Normal"

			-- Statusline
			hl.StatusLineModeNORMAL = { fg = colors.blue, bg = colors.bg_statusline, bold = true }
			hl.StatusLineModeINSERT = { fg = colors.red, bg = colors.bg_statusline, bold = true }
			hl.StatusLineModeVISUAL = { fg = colors.red, bg = colors.bg_statusline, bold = true }
			hl.StatusLineModeSELECT = { fg = colors.red, bg = colors.bg_statusline, bold = true }
			hl.StatusLineModeREPLACE = { fg = colors.red, bg = colors.bg_statusline, bold = true }
			hl.StatusLineModeCOMMAND = { fg = colors.yellow, bg = colors.bg_statusline, bold = true }
			hl.StatusLineModeEX = { fg = colors.yellow, bg = colors.bg_statusline, bold = true }
			hl.StatusLineFilenameModified = { fg = colors.yellow }
			hl.StatusLineExoticFileFormat = { fg = colors.red, bg = colors.bg_statusline }
			hl.StatusLineLspActive = { fg = colors.green }
			hl.StatusLineCopilotActive = { fg = colors.blue }
			hl.StatusLineMacroRecording = { fg = colors.red }
			hl.StatusLineGitStatusClean = { fg = colors.green }
			hl.StatusLineGitStatusDirty = { fg = colors.yellow }
			hl.StatusLineWorkDir = { fg = colors.purple }
			hl.StatusLineGitBranch = { fg = colors.green }
			hl.StatusLineHeading1 = { fg = colors.purple }
			hl.StatusLineHeading2 = { fg = colors.blue }

			-- LSP
			hl.LspInfoBorder = "FloatBorder"

			-- Treesitter Context
			hl.TreesitterContext = "CursorLine"

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

			-- DAP
			hl.DapBreakpoint = { fg = colors.red }
			hl.DapBreakpointLine = { bg = darken(colors.red, 0.1) }
			hl.DapBreakpointRejected = { fg = colors.fg_dark }
			hl.DapLogPoint = { fg = colors.blue }
			hl.DapStopped = { fg = colors.yellow }
			hl.DapStoppedLine = { bg = darken(colors.yellow, 0.1) }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight-storm")
	end,
}
