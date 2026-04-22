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
		input = { enabled = true },
		styles = {
			input = {
				row = 1,
				relative = "cursor",
				noautocmd = false,
			},
		},
	},
	keys = {
		{
			"<Leader>xx",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "Unload current buffer",
		},
		{
			"<Leader>xa",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Unload all buffers",
		},
		{
			"<Leader>xo",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Unload other buffers",
		},
		{
			"<Leader>gg",
			function()
				Snacks.lazygit.open({
					win = {
						on_close = function()
							vim.g.git.update()
						end,
					},
				})
			end,
			desc = "Open Lazygit",
		},
		{
			"<Leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Open Lazygit - Log",
		},
		{
			"<Leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Open Lazygit - Log current file",
		},
		{
			"<Leader>gB",
			function()
				Snacks.terminal("git blame " .. vim.fn.expand("%"), {
					cwd = vim.fn.getcwd(),
					start_insert = false,
				})
			end,
			desc = "Blame file",
		},
		{
			"]n",
			function()
				Snacks.words.jump(1)
			end,
			desc = "Jump to next word",
		},
		{
			"[n",
			function()
				Snacks.words.jump(-1)
			end,
			desc = "Jump to previous word",
		},
		{
			"<Leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Scratch buffer",
		},
	},
}
