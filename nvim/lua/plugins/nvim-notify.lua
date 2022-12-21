 local notify = require('notify')
notify.setup({
	stages = 'static',
	render = 'simple',
	top_down = false,
	on_open = function(win)
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_set_config(win, { border = require('utils.ui').border_float })
			vim.api.nvim_win_set_option(win, "wrap", true)
		end
	end,
})

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.set('NotifyINFOBody', { bg = colors.bg_d })
hl.set('NotifyINFOBorder', { fg = colors.cyan, bg = colors.bg_d })
hl.set('NotifyINFOTitle', { fg = colors.fg, bg = colors.bg_d })

vim.notify = notify
