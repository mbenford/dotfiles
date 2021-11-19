local g = vim.g
g.onedark_style = 'dark'
g.onedark_toggle_style_keymap = '<nop>'
g.onedark_italic_comment = false
g.onedark_darker_diagnostics = false
require'onedark'.setup()
vim.cmd'colorscheme onedark'

local colors = require'onedark.colors'
local hl = require'utils'.hl
hl{'Pmenu', guibg=colors.bg3}
hl{'TablineFill', guibg=colors.bg_d}
hl{'StatusLine', guibg=colors.bg_d}
hl{'StatusLineNC', guibg=colors.bg_d}
