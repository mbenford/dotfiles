return {
	"olimorris/codecompanion.nvim",
	enabled = true,
	version = "17.33.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"franco-ruggeri/codecompanion-spinner.nvim",
	},
	opts = {
		adapters = {
			http = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = { model = { default = "gpt-5-mini" } },
					})
				end,
			},
		},
		strategies = {
			chat = { adapter = "copilot" },
			inline = { adapter = "copilot" },
			cmd = { adapter = "copilot" },
		},
		display = {
			chat = {
				start_in_insert_mode = true,
				icons = {
					buffer_watch = "󰈈 ",
				},
				window = {
					width = 0.35,
					opts = { number = false },
				},
			},
			diff = {
				provider_opts = {
					inline = { layout = "buffer" },
				},
			},
		},
		extensions = {
			spinner = {},
		},
	},
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	keys = {
		{
			"<Leader>cc",
			function()
				require("codecompanion").toggle()
			end,
			mode = { "n", "x" },
			desc = "Toggle chat",
		},
		{
			"<Leader>ca",
			function()
				require("codecompanion").add({})
			end,
			mode = { "n", "x" },
			desc = "Add selection to chat",
		},
		{
			"<Leader>ci",
			"<Cmd>CodeCompanion<CR>",
			mode = { "n" },
			desc = "Inline Assistant",
		},
		{
			"<Leader>ci",
			"<Cmd>'<,'>CodeCompanion<CR>",
			mode = { "x" },
			desc = "Inline Assistant",
		},
	},
}
