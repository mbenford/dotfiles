local border = require('utils.ui').border_float
require('dressing').setup({
	input = {
		border = border,
		winblend = 0,
	},
	select = {
		backend = { 'telescope' },
		telescope = { theme = 'cursor'},
	-- 	builtin = {
	-- 		border = border,
	-- 		winhighlight = 'Normal:NormalFloat',
	-- 		winblend = 0,
	-- 		min_height = 3,
	-- 	}
	},
})
