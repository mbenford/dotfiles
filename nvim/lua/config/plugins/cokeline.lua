return {
	'noib3/cokeline.nvim',
	enabled = false,
	config = function()
		require('cokeline').setup({
			components = {
				{ text = ' ' },
				{
					text = function(buffer)
						local status = ''
						if buffer.is_readonly then
							status = ' '
						end
						return string.format('%s%s%s', buffer.unique_prefix, buffer.filename, status)
					end,
					fg = function(buffer)
						local hl = require('utils.highlight')
						local focused = buffer.is_focused
						local modified = buffer.is_modified

						if focused and modified then
							return hl.get('CokelineFocusedModified').foreground
						elseif focused then
							return hl.get('CokelineFocused').foreground
						elseif modified then
							return hl.get('CokelineModified').foreground
						else
							return hl.get('CokelineUnfocused').foreground
						end
					end,
				},
				{ text = ' ' },
			},
			sidebar = {
				filetype = 'NvimTree',
				components = {
					{
						text = ' NvimTree',
						fg = function(buffer)
							local hl = require('utils.highlight')
							if buffer.is_focused then
								return hl.get('CokelineSidebarFocused').foreground
							end
							return hl.get('CokelineSidebarUnfocused').foreground
						end,
						style = 'none',
					},
				},
			},
			mappings = {
				cycle_prev_next = true,
			},
			default_hl = {
				bg = function(buffer)
					local hl = require('utils.highlight')
					return hl.get('TabLineFill').background
				end,
			},
		})

		require('legendary').keymaps({
			{ '[b', '<Plug>(cokeline-focus-prev)', opts = { noremap = false }, description = '' },
			{ ']b', '<Plug>(cokeline-focus-next)', opts = { noremap = false }, description = '' },
		})
	end,
}
