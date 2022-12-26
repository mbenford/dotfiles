return {
	'rafamadriz/friendly-snippets',
	dependencies = {
		'LuaSnip',
	},
	config = function()
		require('luasnip.loaders.from_vscode').lazy_load()
	end,
}
