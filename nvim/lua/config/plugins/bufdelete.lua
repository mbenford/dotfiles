return {
	'famiu/bufdelete.nvim',
	event = 'BufRead',
	config = function ()
		require('legendary').keymaps({
			{ '<Leader>q<Leader>', '<Cmd>Bdelete<CR>', description = 'Unload current buffer'}
		})
	end
}
