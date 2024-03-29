return {
	'nvim-telescope/telescope-dap.nvim',
	lazy = true,
	dependencies = {
		'nvim-dap',
		'telescope.nvim',
		'nvim-treesitter',
	},
	config = function ()
		require('telescope').load_extension('dap')
	end
}
