require'gitsigns'.setup{
  signs = {
    add          = {text = '▋'},
    change       = {text = '▋'},
    delete       = {text = '▋'},
    topdelete    = {text = '▋'},
    changedelete = {text = '▋'},
  },
	keymaps = {},
}

local hl = require'utils'.hl
hl{'GitSignsChange', guifg=require'onedark.colors'.orange}
