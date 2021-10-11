local g = vim.g
g.onedark_style = 'dark'
g.onedark_disable_toggle_style = 1
g.onedark_italic_comment = false
g.onedark_darker_diagnostics = false
require'onedark'.setup()
vim.cmd'colorscheme onedark'
