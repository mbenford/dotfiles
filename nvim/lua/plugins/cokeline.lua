local colors = require'onedark.colors'

require'cokeline'.setup{
	components = {
		{text = ' '},
		{text = function(buffer) return buffer.unique_prefix end},
		{text = function(buffer) return buffer.filename end},
		{
			text = function(buffer) return buffer.is_modified and ' ' or '' end,
			hl = {fg = function(buffer) return buffer.is_modified and colors.green or colors.fg end},
		},
		{text = ' '},
	},
	cycle_prev_next_mappings = true,
	default_hl = {
		focused = {
			fg = colors.blue,
			bg = colors.bg0,
		},
		unfocused = {
			bg = colors.bg_d,
		},
	}
}

local map = require'map'
map.n{'<C-j>', '<cmd>lua require"cokeline".focus({step = -1})<cr>'}
map.n{'<C-k>', '<cmd>lua require"cokeline".focus({step = 1})<cr>'}
