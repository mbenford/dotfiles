return {
	"obsidian-nvim/obsidian.nvim",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
	},
	version = "*",
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/notes/*.md",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/notes/Personal",
			},
			{
				name = "work",
				path = "~/notes/Work",
			},
		},
		completion = {
			nvm_cmp = false,
			blink = true,
		},
		picker = {
			name = "snacks.pick",
		},
		ui = { enable = false },
	},
}
