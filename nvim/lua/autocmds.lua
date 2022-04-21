local lazy = require('legendary.helpers').lazy
require('legendary').bind_autocmds({
	{ 'FocusLost', 'silent! wa' },
	{ 'TextYankPost', lazy(vim.highlight.on_yank, { higroup = 'TextYank', timeout = 150 }) },

	-- File types
	{ { 'BufNewFile', 'BufRead' }, 'silent! set ft=scss', opts = { pattern = '*.pcss' } },
})
