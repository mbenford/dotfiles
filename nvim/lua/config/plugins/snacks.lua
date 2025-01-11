return {
	"folke/snacks.nvim",
	version = "2.11.0",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = "<Leader>nf" },
					{ icon = " ", key = "ee", desc = "Explore Files", action = "<Leader>ee" },
					{ icon = " ", key = "ff", desc = "Find Files", action = "<Leader>ff" },
					{ icon = " ", key = "fo", desc = "Recent Files", action = "<Leader>fo" },
					{ icon = " ", key = "fg", desc = "Live Grep", action = "<Leader>fg" },
					{ icon = " ", key = "p", desc = "Plugins", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "h", desc = "Check Health", action = ":checkhealth" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		bufdelete = { enabled = true },
		words = {
			enabled = true,
			debounce = 100,
		},
		indent = {
			enabled = true,
			indent = {
				char = "▏",
			},
			scope = {
				enabled = false,
				char = "▏",
			},
			animate = {
				enabled = false,
			},
		},
		lazygit = {
			win = {
				title = " Lazygit ",
				title_pos = "center",
			},
		},
		terminal = {
			win = {
				border = "rounded",
				title_pos = "center",
			},
		},
	},
	keys = {
		{
			"<Leader>xx",
			function()
				require("snacks").bufdelete.delete()
			end,
			desc = "Unload current buffer",
		},
		{
			"<Leader>xa",
			function()
				require("snacks").bufdelete.all()
			end,
			desc = "Unload all buffers",
		},
		{
			"<Leader>xo",
			function()
				require("snacks").bufdelete.other()
			end,
			desc = "Unload other buffers",
		},
		{
			"<Leader>gg",
			function()
				require("snacks").lazygit.open()
			end,
			desc = "Open Lazygit",
		},
		{
			"<Leader>gl",
			function()
				require("snacks").lazygit.log()
			end,
			desc = "Open Lazygit - Log",
		},
		{
			"<Leader>gf",
			function()
				require("snacks").lazygit.log_file()
			end,
			desc = "Open Lazygit - Log current file",
		},
		{
			"<Leader>gd",
			function()
				require("snacks").terminal.open("git diff " .. vim.fn.expand("%"), {
					win = {
						title = "Git Diff",
					},
				})
			end,
			desc = "Diff the current file",
		},
		{
			"]n",
			function()
				require("snacks").words.jump(1)
			end,
			desc = "Jump to next word",
		},
		{
			"[n",
			function()
				require("snacks").words.jump(-1)
			end,
			desc = "Jump to previous word",
		},
	},
}
