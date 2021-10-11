local colors = require'onedark.colors'

require"bufferline".setup{
	options = {
		enforce_regular_tabs = false,
		tab_size = 5,
		show_buffer_icons = false,
		show_close_icon = false,
		show_buffer_close_icons = false,
		indicator_icon = ' ',
		modified_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		separator_style = {'',''},
		offsets = {
			{
				filetype = 'NvimTree',
				text = 'NvimTree',
			}
		},
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, level, dict, context)
			return ''
		end,
	},
	highlights = {
		fill = {
			guibg = colors.bg_d
		},
		background = {
			guibg = colors.bg_d
		},
		indicator_selected = {
			guibg = colors.bg0,
		},
		buffer_selected = {
			gui = 'none',
			guifg = colors.blue,
			guibg = colors.bg0,
		},
		buffer_visible = {
			guibg = colors.bg0,
		},
		modified = {
			guibg = colors.bg_d,
		},
		modified_selected = {
			guibg = colors.bg0,
		},
		modified_visible = {
			guibg = colors.bg0,
		},
		duplicate = {
			gui = 'none',
			guibg = colors.bg_d,
		},
		duplicate_selected = {
			gui = 'none',
			guibg = colors.bg0,
		},
		duplicate_visible = {
			gui = 'none',
			guibg = colors.bg0,
		},
		error = {
			gui = 'undercurl',
			guisp = {attribute = 'fg', highlight = 'LspDiagnosticsDefaultError'},
		},
		error_selected = {
			gui = 'undercurl',
			guisp = {attribute = 'fg', highlight = 'LspDiagnosticsDefaultError'},
		},
		error_visible = {
			guibg = {attribute = 'bg', highlight = 'CursorLine'},
		},
		warning = {
			gui = 'undercurl',
			guisp = {attribute = 'fg', highlight = 'LspDiagnosticsDefaultWarning'},
		},
		warning_selected = {
			gui = 'undercurl',
			guisp = {attribute = 'fg', highlight = 'LspDiagnosticsDefaultWarning'},
		},
		warning_visible = {
			guibg = {attribute = 'bg', highlight = 'CursorLine'},
		},
	}
}
