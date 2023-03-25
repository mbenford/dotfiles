return {
	'navarasu/onedark.nvim',
	enabled = false,
	config = function ()
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
				Pmenu = { bg = '$bg_d' },
				FloatBorder = { fg = '$light_grey' },
				FloatTitle = { fg = 'white', bg = '$cyan' },
				TablineFill = { bg = '$bg_d' },
				StatusLine = { bg = '$bg_d' },
				StatusLineNC = { bg = '$bg_d' },
				SpellBad = { fg = 'none', bg = 'none', sp = 'green', fmt = 'undercurl' },
				TextYank = { fg = '$orange', bg = 'none', fmt = 'reverse' },

				DebugBreakpointSign = { fg = '$red' },
				DebugBreakpointLine = { bg = '$red' },
				DebugStoppedSign = { fg = '$green' },
			},
		})
		onedark.load()

	end
}
