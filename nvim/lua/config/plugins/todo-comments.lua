return {
	"folke/todo-comments.nvim",
	event = "BufRead",
	opts = {
		signs = false,
		highlight = {
			keyword = "fg",
			after = "",
		},
	},
	keys = {
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			buffer = true,
			desc = "Go to prev todo comment",
		},
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			buffer = true,
			desc = "Go to next todo comment",
		},
	},
}
