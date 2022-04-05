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
		FloatBorder = { fg = '$light_grey' },
		TablineFill = { bg = '$bg_d' },
		StatusLine = { bg = '$bg_d' },
		StatusLineNC = { bg = '$bg_d' },
		SpellBad = { fg = 'none', bg = 'none', sp = 'green', fmt = 'undercurl' },
		Folded = { fg = '$grey', bg = 'none' },
		TextYank = { fg = '$orange', bg='none', fmt = 'reverse' },
	},
})
onedark.load()

local hl = require('utils.highlight')
hl.link({ 'LspReferenceRead', 'Visual' })
hl.link({ 'LspReferenceWrite', 'Visual' })
hl.link({ 'LspReferenceText', 'CursorLine' })
hl.link({ 'LspSignatureActiveParameter', 'IncSearch' })
