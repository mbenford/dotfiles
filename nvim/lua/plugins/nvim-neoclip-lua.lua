require('neoclip').setup({})
require('telescope').load_extension('neoclip')

local themes = require('plugins.telescope-themes')
require('legendary').bind_keymaps({
	{
		'<Leader>fc',
		function()
			require('telescope').extensions.neoclip.default()
		end,
		description = 'Fuzzy search for clipboard registers',
	},
})
