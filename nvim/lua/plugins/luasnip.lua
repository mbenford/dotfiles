local luasnip = require('luasnip')
luasnip.config.setup({
	history = true,
})

require('legendary').keymaps({
	{
		'<C-k>',
		function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end,
		mode = { 'i', 's' },
		description = 'Expand snippet or jump to next placeholder',
	},
	{
		'<C-j>',
		function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end,
		mode = { 'i', 's' },
		description = 'Jump to previous placeholder',
	},
})
