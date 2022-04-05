local autocmd = require('utils.autocmd').autocmd
autocmd('FocusLost', '*', 'silent! wa')
autocmd('TextYankPost', '*', function() vim.highlight.on_yank({ higroup = 'TextYank', timeout = 150 }) end)
