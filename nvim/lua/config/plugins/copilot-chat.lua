return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	build = "make tiktoken",
	opts = {
		model = "claude-3.5-sonnet",
		question_header = "󰭹 ",
		answer_header = " ",
		error_header = " ",
		insert_at_end = true,
	},
	init = function()
		require("which-key").add({
			{ "<Leader>c", group = "Copilot Chat", icon = "" },
		})
	end,
	keys = {
		{
			"<Leader>cc",
			function()
				require("CopilotChat").toggle()
			end,
			mode = { "n", "x" },
			desc = "Toggle chat",
		},
		{
			"<leader>cq",
			function()
				local input = vim.fn.input("Copilot Chat: ")
				if input ~= "" then
					local mode = vim.api.nvim_get_mode().mode
					local select = require("CopilotChat.select")
					require("CopilotChat").ask(input, { selection = mode == "n" and select.buffer or select.visual })
				end
			end,
			mode = { "n", "x" },
			desc = "Quick chat",
		},
		{
			"<leader>cp",
			function()
				local actions = require("CopilotChat.actions")
				actions.pick(actions.prompt_actions())
			end,
			mode = { "n", "x" },
			desc = "Prompt actions",
		},
		{
			"<leader>ce",
			function()
				local mode = vim.api.nvim_get_mode().mode
				local select = require("CopilotChat.select")
				require("CopilotChat").ask(
					"Explain what this does",
					{ selection = mode == "n" and select.buffer or select.visual }
				)
			end,
			mode = { "n", "x" },
			desc = "Explain",
		},
	},
}
