require('close_buffers').setup({
	preserve_window_layout = { 'this', 'nameless' },
})

local map = require('utils.map').map
map('n', '<leader>qb', '<cmd>BDelete this<cr>')
map('n', '<leader>qo', '<cmd>BDelete other<cr>')
map('n', '<leader>qa', '<cmd>BDelete all<cr>')
