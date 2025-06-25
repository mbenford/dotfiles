return {
	"mrjones2014/smart-splits.nvim",
	cond = not vim.env.DEVPOD,
	build = "./kitty/install-kittens.bash",
	lazy = false,
	opts = {},
	keys = {
		{
			"<A-h>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			desc = "",
		},
		{
			"<A-j>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "",
		},
		{
			"<A-k>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "",
		},
		{
			"<A-l>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "",
		},
	},
}
