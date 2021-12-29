require'hop'.setup{
	teasing = false,
	char2_fallback_key = '<cr>',
}

local map = require'map'
map.a{'f', '<cmd>HopChar1CurrentLine<cr>'}
map.a{'F', '<cmd>HopChar2<cr>'}
map.a{'gl', '<cmd>HopLine<cr>'}
map.a{'gL', '<cmd>HopLineStart<cr>'}

local colors = require'onedark.colors'
local hl = require'highlight'
hl.add{'HopNextKey', guifg=colors.bg0, guibg=colors.orange}
hl.add{'HopNextKey1', guifg=colors.bg0, guibg=colors.orange, gui='none'}
hl.add{'HopNextKey2', guifg=colors.bg0, guibg=colors.yellow}
hl.add{'HopUnmatched', guifg='none', guibg='none'}
