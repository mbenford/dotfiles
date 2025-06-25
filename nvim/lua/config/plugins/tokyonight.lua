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
			hl.TextYank = { bg = darken(colors.yellow, 0.2) }
			hl.FloatTitle = { fg = colors.border_highlight, bg = colors.bg_float }
			hl.WinBar = "Normal"
			hl.WinBarNC = "Normal"

			-- Statusline
			hl.StatusLineModeNORMAL = { fg = colors.bg_statusline, bg = colors.blue, bold = true }
			hl.StatusLineModeINSERT = { fg = colors.bg_statusline, bg = colors.green, bold = true }
			hl.StatusLineModeVISUAL = { fg = colors.bg_statusline, bg = colors.purple, bold = true }
			hl.StatusLineModeSELECT = { fg = colors.bg_statusline, bg = colors.purple, bold = true }
			hl.StatusLineModeREPLACE = { fg = colors.bg_statusline, bg = colors.red, bold = true }
			hl.StatusLineModeCOMMAND = { fg = colors.bg_statusline, bg = colors.yellow, bold = true }
			hl.StatusLineModeTERM = { fg = colors.bg_statusline, bg = colors.orange, bold = true }
			hl.StatusLineModeMORE = { fg = colors.bg_statusline, bg = colors.magenta, bold = true }
			hl.StatusLineModeUNKNOWN = { fg = colors.bg_statusline, bg = colors.fg, bold = true }
			hl.StatusLineModeEX = { fg = colors.bg_statusline, bg = colors.yellow, bold = true }
			hl.StatusLineFilenameModified = { fg = colors.yellow }
			hl.StatusLineExoticFileFormat = { fg = colors.red, bg = colors.bg_statusline }
			hl.StatusLineLspActive = { fg = colors.yellow }
			hl.StatusLineDapActive = { fg = colors.green }
			hl.StatusLineCopilotActive = { fg = colors.green }
			hl.StatusLineMacroRecording = { fg = colors.red }
			hl.StatusLineGitStatusClean = { fg = colors.green }
			hl.StatusLineGitStatusDirty = { fg = colors.yellow }
			hl.StatusLineWorkDir = { fg = colors.teal, bold = true }
			hl.StatusLineGitBranch = { fg = colors.green }
			hl.StatusLineGitCommits = { fg = colors.blue }
			hl.StatusLineDevPod = { fg = colors.purple, bold = true }

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
