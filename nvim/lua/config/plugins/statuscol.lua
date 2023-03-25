return {
	'luukvbaal/statuscol.nvim',
	config = function()
		local builtin = require('statuscol.builtin')
		require('statuscol').setup({
			ft_ignore = {
				'NvimTree',
			},
			relculright = true,
			segments = {
				{ text = { builtin.lnumfunc, ' ' } },
				{ text = { '%s' } },
				{ text = { builtin.foldfunc, ' ' } },
			},
		})
	end,
}
