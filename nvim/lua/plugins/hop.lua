require'hop'.setup{
	teasing = false,
}

local map = require'map'
map.n{'<leader>hc', '<cmd>HopChar1<cr>'}
map.n{'<leader>hf', '<cmd>HopChar1CurrentLine<cr>'}
map.n{'<leader>hw', '<cmd>HopWord<cr>'}
map.n{'<leader>hl', '<cmd>HopLine<cr>'}
