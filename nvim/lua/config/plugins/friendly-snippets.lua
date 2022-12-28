return {
	'rafamadriz/friendly-snippets',
	event = 'InsertEnter',
	dependencies = {
		'LuaSnip',
	},
	config = function()
		require('luasnip.loaders.from_vscode').lazy_load()
	end,
}
