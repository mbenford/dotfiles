return {
	'rcarriga/nvim-notify',
	-- event = 'VeryLazy',
	config = function()
		require('notify').setup({
			stages = 'static',
			render = 'simple',
			top_down = false,
			on_open = function(win)
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_set_config(win, { border = require('utils.ui').border_float })
					vim.api.nvim_win_set_option(win, 'wrap', true)
				end
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.5)
			end,
			max_height = function()
				return math.floor(vim.o.lines * 0.3)
			end,
		})

		vim.notify = require('notify')
	end,
}
