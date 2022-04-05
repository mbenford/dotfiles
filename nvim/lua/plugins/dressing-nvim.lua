require('dressing').setup({
	input = {
		border = require('utils.ui').border_float,
		prompt_align = 'center',
		min_width = { 30, 0.2 },
		winblend = 0,
		winhighlight = 'Normal:NormalInput,FloatBorder:FloatBorderInput',
	},
	select = {
		backend = { 'telescope' },
		--telescope = { theme = 'cursor'},
	},
})

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.add({ 'FloatTitle', guifg = 'white', guibg = colors.cyan })
hl.add({ 'NormalInput', guibg = colors.bg0 })
hl.add({ 'FloatBorderInput', guifg = colors.cyan })
hl.add({ 'DressingInputText', guifg = colors.fg, guibg = colors.bg0 })
