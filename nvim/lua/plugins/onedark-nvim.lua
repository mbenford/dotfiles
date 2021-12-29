local g = vim.g
g.onedark_style = 'dark'
g.onedark_toggle_style_keymap = '<nop>'
g.onedark_italic_comment = false
g.onedark_darker_diagnostics = false
require'onedark'.setup()
vim.cmd'colorscheme onedark'

local colors = require'onedark.colors'
local hl = require'highlight'
hl.add{'Pmenu', guibg=colors.bg3}
hl.add{'TablineFill', guibg=colors.bg_d}
hl.add{'StatusLine', guibg=colors.bg_d}
hl.add{'StatusLineNC', guibg=colors.bg_d}

hl.link{'LspReferenceRead', 'Visual'}
hl.link{'LspReferenceWrite', 'Visual'}
hl.link{'LspReferenceText', 'CursorLine'}
