local hop = require('hop')
hop.setup({
	teasing = false,
	char2_fallback_key = '<cr>',
})

local AFTER_CURSOR = require('hop.hint').HintDirection.AFTER_CURSOR
local BEFORE_CURSOR = require('hop.hint').HintDirection.BEFORE_CURSOR

local lazy = require('legendary.toolbox').lazy
require('legendary').keymaps({
	{
		'<Leader>h',
		lazy(hop.hint_char2, { multi_windows = false }),
		mode = { 'n', 'x', 'o' },
		description = 'Hop 2-char mode (current window)',
	},
	{
		'<Leader>H',
		lazy(hop.hint_char2, { multi_windows = true }),
		mode = { 'n', 'x' },
		description = 'Hop 2-char mode (multi-windows)',
	},
	{
		'f',
		lazy(hop.hint_char1, { direction = AFTER_CURSOR, current_line_only = true }),
		mode = { 'n', 'x', 'o' },
		description = 'Hop 1-char mode (current line forward)',
	},
	{
		'F',
		lazy(hop.hint_char1, { direction = BEFORE_CURSOR, current_line_only = true }),
		mode = { 'n', 'x', 'o' },
		description = 'Hop 1-char mode (current line backward)',
	},
	{
		't',
		lazy(hop.hint_char1, { direction = AFTER_CURSOR, current_line_only = true, hint_offset = -1 }),
		mode = { 'n', 'x', 'o' },
		description = 'Hop 1-char mode (exclusive, current line forward)',
	},
	{
		'T',
		lazy(hop.hint_char1, { direction = BEFORE_CURSOR, current_line_only = true, hint_offset = -1 }),
		mode = { 'n', 'x', 'o' },
		description = 'Hop 1-char mode (exclusive, current line backward)',
	},
	{
		'gl',
		lazy(hop.hint_lines, { multi_windows = false }),
		mode = { 'n', 'x', 'o' },
		description = 'Hop line mode (current window)',
	},
	{
		'gL',
		lazy(hop.hint_lines, { multi_windows = true }),
		mode = { 'n', 'x' },
		description = 'Hop line mode (multi-windows)',
	},
})

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.set('HopNextKey', { fg = colors.bg0, bg = colors.orange })
hl.set('HopNextKey1', { fg = colors.bg0, bg = colors.orange })
hl.set('HopNextKey2', { fg = colors.bg0, bg = colors.yellow })
hl.set('HopUnmatched', { fg = 'none', bg = 'none' })
