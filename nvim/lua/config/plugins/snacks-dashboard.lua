local version = vim.version()
return {
	"folke/snacks.nvim",
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "n", desc = "New", action = "<Leader>nf" },
					{ icon = " ", key = "ee", desc = "Explore", action = "<Leader>ee" },
					{ icon = " ", key = "ff", desc = "Find", action = "<Leader>ff" },
					{ icon = " ", key = "fo", desc = "Recent", action = "<Leader>fo" },
					{ icon = " ", key = "fg", desc = "Grep", action = "<Leader>fg" },
					{ icon = " ", key = "p", desc = "Plugins", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "h", desc = "Health", action = ":checkhealth" },
					{ icon = " ", key = "q", desc = "Quit", action = require("utils.remote").detach_or_quit },
				},
				header = table.concat({
					[[                                                                       ]],
					[[  ██████   █████                   █████   █████  ███                  ]],
					[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
					[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
					[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
					[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
					[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
					[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
					[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
					[[                                                                       ]],
					string.format("%s.%s.%s", version.major, version.minor, version.patch),
				}, "\n"),
			},
			sections = {
				{ section = "header" },
				function()
					return {
						text = {
							{ " " .. require("utils.misc").work_dir(), hl = "StatusLineWorkDir" },
						},
						align = "center",
						padding = 1,
					}
				end,
				{ section = "keys", gap = 1, padding = 2 },
				{ section = "startup" },
			},
		},
	},
}
