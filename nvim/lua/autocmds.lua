local autocmd = require('utils.autocmd').autocmd
autocmd('FocusLost', { pattern = '*', command = 'silent! wa' })
autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'TextYank', timeout = 150 })
	end,
})
