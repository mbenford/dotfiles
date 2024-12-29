local components = require("config.plugins.lualine.components")
local extensions = require("config.plugins.lualine.extensions")

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "tokyonight",
			globalstatus = vim.o.laststatus == 3,
			icons_enabled = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				components.cwd,
			},
			lualine_b = {},
			lualine_c = {
				components.filename,
			},
			lualine_x = {
				components.recording_status,
				components.git_branch,
				components.diagnostics,
				components.lsp,
				components.filetype,
				components.indentation,
				components.file_encoding,
				components.file_format,
				components.location,
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { components.filename },
			lualine_x = { components.filetype },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			"lazy",
			"man",
			"mason",
			"nvim-dap-ui",
			"quickfix",
			"trouble",
			extensions.telescope,
			extensions.mini_files,
			extensions.copilot_chat,
			extensions.snacks,
			extensions.help,
		},
	},
}
