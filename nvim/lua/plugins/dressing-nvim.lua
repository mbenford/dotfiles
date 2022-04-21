require('dressing').setup({
	input = {
		border = require('utils.ui').border_float,
		prompt_align = 'center',
		winblend = 0,
		winhighlight = 'Normal:NormalInput,FloatBorder:FloatBorderInput',
		prefer_width = 20,
		min_width = { 20, 0.1 },
		get_config = function(opts)
			if string.len(opts.default) > 0 then
				return {
					min_width = string.len(opts.default) + 10,
				}
			end
		end,
	},
	select = {
		backend = { 'telescope' },
		--telescope = { theme = 'cursor'},
	},
})

local colors = require('onedark.colors')
local set_hl = vim.api.nvim_set_hl
set_hl(0, 'NormalInput', { bg = colors.bg0 })
set_hl(0, 'FloatBorderInput', { fg = colors.cyan })
