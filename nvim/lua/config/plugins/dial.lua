return {
	'monaqa/dial.nvim',
	config = function()
		local augend = require('dial.augend')
		require('dial.config').augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.constant.alias.bool,
			},
		})
	end,
}
