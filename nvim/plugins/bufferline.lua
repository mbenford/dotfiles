require("bufferline").setup{
	options = {
		show_close_icon = false,
		show_buffer_close_icons = false,
		indicator_icon = ' ',
		modified_icon = '',
		separator_style = {'',''},
		tab_size = 5,
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
		custom_areas = {
			right = function()
				local error = vim.lsp.diagnostic.get_count(0, [[Error]])
				local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
				local info = vim.lsp.diagnostic.get_count(0, [[Information]])
				local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])
				local result = {}

				if error ~= 0 then
					table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
				end

				if warning ~= 0 then
					table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
				end

				if hint ~= 0 then
					table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
				end

				if info ~= 0 then
					table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
				end

				return result
			end,
		},
	},
	highlights = {
		fill = {
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
		},
		background = {
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
		},
		buffer_selected = {
			gui = 'none',
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		buffer_visible = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		indicator_selected = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		modified = {
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' }
		},
		modified_selected = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		modified_visible = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		duplicate = {
			gui = 'none',
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
		},
		duplicate_selected = {
			gui = 'none',
			guibg = { attribute = 'bg', highlight = 'CursorLine' },
		},
		duplicate_visible = {
			gui = 'none',
			guibg = { attribute = 'bg', highlight = 'CursorLine' },
		},
		error = {
			gui = 'undercurl',
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
			guisp = { attribute = 'fg', highlight = 'LspDiagnosticsDefaultError' },
		},
		error_selected = {
			gui = 'undercurl',
			guifg = 'none',
			guibg = { attribute = 'bg', highlight = 'CursorLine' },
			guisp = { attribute = 'fg', highlight = 'LspDiagnosticsDefaultError' },
		},
		error_visible = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' },
		},
		warning = {
			gui = 'undercurl',
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
			guisp = { attribute = 'fg', highlight = 'LspDiagnosticsDefaultWarning' },
		},
		warning_selected = {
			gui = 'undercurl',
			guifg = 'none',
			guibg = { attribute = 'bg', highlight = 'CursorLine' },
			guisp = { attribute = 'fg', highlight = 'LspDiagnosticsDefaultWarning' },
		},
		warning_visible = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' },
		},
	}
}
