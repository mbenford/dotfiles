require'gitsigns'.setup{
  signs = {
    add          = {text = '▋'},
    change       = {text = '▋'},
    delete       = {text = '▁'},
    topdelete    = {text = '▔'},
    changedelete = {text = '▋'},
  },
	keymaps = {},
	preview_config = {
		border = '',
	},
}

local map = require'map'
map.n{'<leader><leader>gp', '<cmd>Gitsigns preview_hunk<cr>'}
map.n{'<leader><leader>gr', '<cmd>Gitsigns reset_hunk<cr>'}
map.n{'<leader><leader>gn', '<cmd>Gitsigns next_hunk<cr>'}
map.n{'<leader><leader>gN', '<cmd>Gitsigns prev_hunk<cr>'}
map.n{'<leader><leader>gb', '<cmd>Gitsigns blame_line<cr>'}

local hl = require'highlight'
hl.add{'GitSignsChange', guifg=require'onedark.colors'.orange, guibg='none'}
