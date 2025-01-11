local components = require("config.plugins.lualine.components")

local M = {}

M.telescope = {
	sections = {
		lualine_a = {
			"'Telescope'",
		},
		lualine_b = {
			function()
				local action_state = require("telescope.actions.state")
				local curr_picker = action_state.get_current_picker(vim.api.nvim_get_current_buf())
				return curr_picker.prompt_title
			end,
		},
		lualine_x = {
			components.git_branch,
		},
	},
	filetypes = { "TelescopePrompt" },
}

M.mini_files = {
	sections = {
		lualine_a = {
			"'Mini Files'",
		},
		lualine_b = {
			function()
				return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
			end,
		},
		lualine_x = {
			components.git_branch,
		},
	},
	filetypes = { "minifiles", "minifiles-help" },
}

M.copilot_chat = {
	sections = {
		lualine_a = {
			"'Copilot Chat'",
		},
		lualine_b = {
			function()
				return require("CopilotChat").config.model
			end,
		},
		lualine_x = {
			components.location,
		},
	},
	filetypes = { "copilot-chat", "copilot-overlay" },
}

M.snacks_dashboard = {
	sections = {
		lualine_a = {
			components.cwd,
		},
		lualine_b = {},
		lualine_x = {
			components.git_branch,
		},
	},
	filetypes = { "snacks_dashboard", "snacks_terminal" },
}

M.help = {
	sections = {
		lualine_a = {
			"'Help'",
		},
		lualine_b = {
			components.filename,
		},
		lualine_x = {
			components.location,
		},
	},
	filetypes = { "help" },
}

return M
