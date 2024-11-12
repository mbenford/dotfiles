return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		stages = "static",
		render = "wrapped-compact",
		on_open = function(win)
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_option(win, "wrap", true)
			end
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.5)
		end,
		max_height = function()
			return math.floor(vim.o.lines * 0.3)
		end,
	},
	config = function(_, opts)
		require("notify").setup(opts)
		vim.notify = require("notify")
	end,
}
