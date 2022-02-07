require('neorg').setup({
	load = {
		['core.defaults'] = {}, -- Load all the default modules
		['core.norg.concealer'] = {}, -- Allows for use of icons
		['core.norg.completion'] = {
			config = {
				engine = 'nvim-cmp',
			},
		},
	},
})
