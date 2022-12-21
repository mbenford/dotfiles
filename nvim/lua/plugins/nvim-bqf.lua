local borders = require('utils.ui').borders
require('bqf').setup({
	preview = {
		show_title = false,
		border_chars = {
			borders.left,
			borders.right,
			borders.top,
			borders.bottom,
			borders.top_left,
			borders.top_right,
			borders.bottom_left,
			borders.bottom_right,
			borders.right,
		},
	},
})

local hl = require('utils.highlight')
local float_border = hl.get('FloatBorder')
hl.set('BqfPreviewBorder', { fg = float_border.foreground })
