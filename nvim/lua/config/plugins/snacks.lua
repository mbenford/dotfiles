return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		bufdelete = { enabled = true },
		words = { enabled = true, debounce = 100 },
		indent = {
			enabled = true,
			indent = { char = "▏" },
			scope = { enabled = false, char = "▏" },
			animate = { enabled = false },
		},
		lazygit = {
			win = {
				backdrop = false,
				title = " Lazygit ",
				title_pos = "center",
			},
		},
		terminal = {
			win = { border = "rounded", title_pos = "center" },
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
