return {
	'windwp/nvim-autopairs',
	event = 'BufRead',
	config = function()
		require('nvim-autopairs').setup({
			enable_moveright = true,
		})

		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { text = '' } }))
	end,
}
