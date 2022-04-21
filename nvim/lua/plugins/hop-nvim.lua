local hop = require('hop')
hop.setup({
	teasing = false,
	char2_fallback_key = '<cr>',
})

local curr_line_ac = { current_line_only = true, direction = require('hop.hint').HintDirection.AFTER_CURSOR }
local curr_line_bc = { current_line_only = true, direction = require('hop.hint').HintDirection.BEFORE_CURSOR }

local lazy = require('legendary.helpers').lazy
require('legendary').bind_keymaps({
	{ 's', hop.hint_char2, mode = { 'n', 'v' }, description = '' },
	{ 'S', lazy(hop.hint_char2, { multi_windows = true }), mode = { 'n', 'v' }, description = '' },
	{ 'f', lazy(hop.hint_char1, curr_line_ac), description = '' },
	{ 'F', lazy(hop.hint_char1, curr_line_bc), description = '' },
	{
		'f',
		lazy(hop.hint_char1, vim.tbl_extend('force', curr_line_ac, { inclusive_jump = true })),
		mode = { 'x', 'o' },
		description = '',
	},
	{
		'F',
		lazy(hop.hint_char1, vim.tbl_extend('force', curr_line_bc, { inclusive_jump = true })),
		mode = { 'x', 'o' },
		description = '',
	},
	{ 't', lazy(hop.hint_char1, curr_line_bc), mode = { 'n', 'x', 'o' }, description = '' },
	{ 'T', lazy(hop.hint_char1, curr_line_ac), mode = { 'n', 'x', 'o' }, description = '' },
	{ 'gl', hop.hint_lines, mode = { 'n', 'v' }, description = '' },
	{ 'gL', lazy(hop.hint_lines, { multi_windows = true }), mode = { 'n', 'v' }, description = '' },
})

local colors = require('onedark.colors')
local set_hl = vim.api.nvim_set_hl
set_hl(0, 'HopNextKey', { fg = colors.bg0, bg = colors.orange })
set_hl(0, 'HopNextKey1', { fg = colors.bg0, bg = colors.orange  })
set_hl(0, 'HopNextKey2', { fg = colors.bg0, bg = colors.yellow })
set_hl(0, 'HopUnmatched', { fg = 'none', bg = 'none' })
