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
			desc = "Move cursor to left window",
		},
		{
			"<A-j>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "Move cursor to window below",
		},
		{
			"<A-k>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "Move cursor to window above",
		},
		{
			"<A-l>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "Move cursor to right window",
		},
		{
			"<C-A-h>",
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize window left",
		},
		{
			"<C-A-j>",
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize window down",
		},
		{
			"<C-A-k>",
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize window up",
		},
		{
			"<C-A-l>",
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize window right",
		},
	},
}
