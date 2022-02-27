local onedark = require('onedark')
onedark.setup({
	style = 'dark',
	code_style = {
		comments = 'none',
	},
	toggle_style_key = '<nop>',
	diagnostics = {
		darker = false,
	},
	highlights = {
		Pmenu = { bg = '$bg3' },
		FloatBorder = { fg = '$light_grey', bg = '$bg3' },
		TablineFill = { bg = '$bg_d' },
		StatusLine = { bg = '$bg_d' },
		StatusLineNC = { bg = '$bg_d' },
		SpellBad = { fg = 'none', bg = 'none', sp = 'green', fmt = 'undercurl' },
		Folded = { fg = '$grey', bg = 'none' },
	},
})
onedark.load()

local hl = require('utils.highlight')
hl.link({ 'LspReferenceRead', 'Visual' })
hl.link({ 'LspReferenceWrite', 'Visual' })
hl.link({ 'LspReferenceText', 'CursorLine' })
hl.link({ 'LspSignatureActiveParameter', 'IncSearch' })
