require('neorg').setup({
	load = {
		['core.defaults'] = {},
		['core.norg.concealer'] = {
			config = {
				icon_preset = 'varied',
			},
		},
		['core.norg.completion'] = {
			config = {
				engine = 'nvim-cmp',
			},
		},
	},
})
