return {
	"CopilotC-Nvim/CopilotChat.nvim",
	enabled = true,
	branch = "canary",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	build = "make tiktoken",
	opts = {
		model = "claude-3.5-sonnet",
		window = {
			layout = "vertical",
			width = 0.3,
		},
	},
	keys = {
		{
			"<Leader>aa",
			function()
				require("CopilotChat").toggle()
			end,
			desc = "Toggle Copilot Chat",
		},
	},
}
