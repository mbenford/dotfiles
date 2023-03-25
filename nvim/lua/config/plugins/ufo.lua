return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		'kevinhwang91/promise-async',
	},
	event = 'BufRead',
	config = function()
		require('ufo').setup({
			provider_selector = function()
				return { 'treesitter', 'indent' }
			end,
		})

		local ufo = require('ufo')
		require('legendary').keymaps({
			{ 'zR', ufo.openAllFolds, description = '' },
			{ 'zr', ufo.openAllFolds, description = '' },
			{ 'zM', ufo.closeAllFolds, description = '' },
			{ 'zm', ufo.closeFoldsWith, description = '' },
		})
	end,
}
