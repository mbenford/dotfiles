return {
	"CopilotC-Nvim/CopilotChat.nvim",
	enabled = false,
	branch = "main",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	build = "make tiktoken",
	opts = {
		model = "claude-sonnet-4.5",
		insert_at_end = true,
		show_help = false,
		auto_fold = true,
		window = {
			width = 0.4,
		},
		separator = "━━",
		headers = {
			user = " You",
			assistant = " Copilot",
			tool = " Tool",
		},
	},
	init = function()
		require("which-key").add({
			{ "<Leader>c", group = "Copilot Chat", icon = "" },
		})
	end,
	config = function(_, opts)
		require("CopilotChat").setup(opts)

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				local o = vim.opt_local
				o.relativenumber = false
				o.number = false
				o.conceallevel = 0
			end,
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
				local mode = vim.api.nvim_get_mode().mode
				vim.ui.input({ prompt = "Copilot Quick Chat: " }, function(input)
					if input and input ~= "" then
						vim.schedule_wrap(function() end)
						vim.cmd.normal({ "gv", bang = true })
						require("CopilotChat").ask(input, { resources = mode == "n" and "buffer" or "selection" })
					end
				end)
			end,
			mode = { "n", "x" },
			desc = "Quick chat",
		},
		{
			"<leader>cp",
			function() end,
			mode = { "n", "x" },
			desc = "Prompt actions",
		},
		{
			"<leader>ce",
			function()
				local mode = vim.api.nvim_get_mode().mode
				require("CopilotChat").ask("Explain what this does", { resources = mode == "n" and "buffer" or "selection" })
			end,
			mode = { "n", "x" },
			desc = "Explain",
		},
	},
}
