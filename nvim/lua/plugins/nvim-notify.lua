local notify = require('notify')
notify.setup({
	stages = 'static',
	render = 'minimal',
	on_open = function(win)
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_set_config(win, { border = require('utils.ui').border_float })
		end
	end,
})

local colors = require('onedark.colors')
local set_hl = vim.api.nvim_set_hl
set_hl(0, 'NotifyINFOBody', { bg = colors.bg_d })
set_hl(0, 'NotifyINFOBorder', { fg = colors.cyan, bg = colors.bg_d })
set_hl(0, 'NotifyINFOTitle', { fg = colors.fg, bg = colors.bg_d })

vim.notify = notify
