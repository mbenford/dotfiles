require'gitsigns'.setup{
  signs = {
    add          = {text = '▋'},
    change       = {text = '▋'},
    delete       = {text = '▋'},
    topdelete    = {text = '▋'},
    changedelete = {text = '▋'},
  },
}

vim.cmd[[
	hi GitSignsChange guifg=#d19a66
]]
