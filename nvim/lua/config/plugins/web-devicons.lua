return {
	'kyazdani42/nvim-web-devicons',
	lazy = true,
	config = function()
		require('nvim-web-devicons').setup({
			default = true,
			override = {
				css = {
					icon = '',
					color = '#264de4',
					name = 'CSS',
				},
				tf = {
					icon = '',
					color = '#8956c4',
					name = 'terraform',
				},
			},
		})
	end
}
