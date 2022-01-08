local colors = require'onedark.colors'
require'cokeline'.setup{
	components = {
		{text = ' '},
		{text = function(buffer) return buffer.unique_prefix end},
		{
			text = function(buffer)
				local status = ''
				if buffer.is_readonly then
					status = ' '
				end
				return buffer.filename .. status
			end,
			hl = {
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
				end},
		},
		{text = ' '},
	},
	rendering = {
		left_sidebar = {
			filetype = 'NvimTree',
			components = {
				{
					text = '',
					hl = {
						fg = colors.yellow,
						bg = colors.bg_d,
						style = 'bold',
					},
				},
			},
		},
	},
	mappings = {
		cycle_prev_next = true,
	},
	default_hl = {
		focused = {
			bg = colors.bg0,
		},
		unfocused = {
			bg = colors.bg_d,
		},
	}
}

local map = require'utils.map'
map.n{'<C-j>', '<Plug>(cokeline-focus-prev)', noremap = false}
map.n{'<C-k>', '<Plug>(cokeline-focus-next)', noremap = false}
