return {
	'rcarriga/nvim-notify',
	config = {
		stages = 'static',
		render = 'simple',
		top_down = false,
		on_open = function(win)
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_config(win, { border = require('utils.ui').border_float })
				vim.api.nvim_win_set_option(win, "wrap", true)
			end
		end,
	},
	init = function()
		local colors = require('onedark.colors')
		local hl = require('utils.highlight')
		hl.set('notifyinfobody', { bg = colors.bg_d })
		hl.set('notifyinfoborder', { fg = colors.cyan, bg = colors.bg_d })
		hl.set('notifyinfotitle', { fg = colors.fg, bg = colors.bg_d })

		vim.notify = require('notify')
	end,
}

