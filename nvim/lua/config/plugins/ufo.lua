return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		'kevinhwang91/promise-async',
	},
	event = 'BufRead',
	opts = {
		open_fold_hl_timeout = 0,
		provider_selector = function()
			return { 'treesitter', 'indent' }
		end,
	},
	config = function(_, opts)
		local ufo = require('ufo')
		ufo.setup(opts)

		require('legendary').keymaps({
			{ 'zR', ufo.openAllFolds, description = '' },
			{ 'zr', ufo.openAllFolds, description = '' },
			{ 'zM', ufo.closeAllFolds, description = '' },
			{ 'zm', ufo.closeFoldsWith, description = '' },
		})
	end,
}
