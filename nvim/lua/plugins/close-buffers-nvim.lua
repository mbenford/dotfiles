require'close_buffers'.setup{
	preserve_window_layout = {'this', 'nameless'},
}

local map = require'utils.map'
map.n{'<leader>xc', '<cmd>BDelete this<cr>'}
map.n{'<leader>xo', '<cmd>BDelete other<cr>'}
map.n{'<leader>xa', '<cmd>BDelete all<cr>'}
