return {
	'L3MON4D3/LuaSnip',
	dependencies = {
		'nvim-cmp',
	},
	config = function()
		require('luasnip').config.setup({
			history = true,
		})
	end,
	init = function()
		local luasnip = require('luasnip')
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
	end,
}
