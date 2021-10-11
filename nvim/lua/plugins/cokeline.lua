local colors = require'onedark.colors'

require'cokeline'.setup{
	components = {
		{text = ' '},
		{text = function(buffer) return buffer.unique_prefix end},
		{text = function(buffer) return buffer.filename end},
		{
			text = function(buffer)
				if buffer.is_modified then
					return ' '
				end
				return ''
			end
		},
		{text = ' '},
	},
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

vim.cmd('hi TablineFill guibg=' .. colors.bg_d)
