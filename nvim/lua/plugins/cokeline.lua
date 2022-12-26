return {
	'noib3/cokeline.nvim',
	config = function()
		local colors = require('onedark.colors')
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
						local focused = buffer.is_focused
						local modified = buffer.is_modified

						if focused and modified then
							return colors.yellow
						elseif focused then
							return colors.fg
						elseif modified then
							return colors.dark_yellow
						else
							return colors.grey
						end
					end,
				},
				{ text = ' ' },
			},
			sidebar = {
				filetype = 'NvimTree',
				components = {
					{
						text = ' File Explorer',
						fg = function(buffer)
							return buffer.is_focused and colors.fg or colors.grey
						end,
						bg = colors.bg_d,
						style = 'none',
					},
				},
			},
			mappings = {
				cycle_prev_next = true,
			},
			default_hl = {
				bg = function(buffer)
					if buffer.is_focused then
						return colors.bg0
					end

					return colors.bg_d
				end,
			},
		})
	end,
	init = function()
		require('legendary').keymaps({
			{ '<C-j>', '<Plug>(cokeline-focus-prev)', opts = { noremap = false }, description = '' },
			{ '<C-k>', '<Plug>(cokeline-focus-next)', opts = { noremap = false }, description = '' },
		})
	end,
}
