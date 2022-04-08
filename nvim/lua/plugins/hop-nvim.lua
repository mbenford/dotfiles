local hop = require('hop')
hop.setup({
	teasing = false,
	char2_fallback_key = '<cr>',
})

local map = require('utils.map').map
map('', 's', function() hop.hint_char2() end)
map('', 'S', function() hop.hint_char2({ multi_windows = true }) end)
map('n', 'f', function() hop.hint_char1({ current_line_only = true }) end)
map('o', 'f', function() hop.hint_char1({ current_line_only = true, inclusive_jump = true }) end)
map('x', 'f', function() hop.hint_char1({ current_line_only = true, inclusive_jump = true }) end)
map('', 't', function() hop.hint_char1({ current_line_only = true }) end)
map('', 'gl', function() hop.hint_lines() end)
map('', 'gL', function() hop.hint_lines_skip_whitespace() end)

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.add({ 'HopNextKey', guifg = colors.bg0, guibg = colors.orange })
hl.add({ 'HopNextKey1', guifg = colors.bg0, guibg = colors.orange, gui = 'none' })
hl.add({ 'HopNextKey2', guifg = colors.bg0, guibg = colors.yellow })
hl.add({ 'HopUnmatched', guifg = 'none', guibg = 'none' })
