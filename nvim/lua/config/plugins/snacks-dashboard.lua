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
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
					vim.version().build,
				}, "\n"),
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 2 },
				{ section = "startup" },
			},
		},
	},
}
