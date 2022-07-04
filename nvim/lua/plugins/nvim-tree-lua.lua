require('nvim-tree').setup({
	update_cwd = true,
	filters = {
		custom = { '.git' },
	},
	view = {
		signcolumn = 'no',
	},
	renderer = {
		special_files = {},
		highlight_git = true,
		icons = {
			symlink_arrow = ' -> ',
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},
		},
	},
	update_focused_file = {
		enable = true,
	},
})

require('nvim-tree.events').on_file_created(function(file)
	vim.cmd('edit ' .. file.fname)
end)

require('legendary').bind_keymaps({
	{ '<Leader>e', '<Cmd>NvimTreeToggle<CR>', description = 'Toggles NvimTree' },
})

local colors = require('onedark.colors')
local set_hl = vim.api.nvim_set_hl
set_hl(0, 'NvimTreeNormal', { bg = colors.bg0 })
set_hl(0, 'NvimTreeEndOfBuffer', { fg = colors.bg0, bg = colors.bg0 })
set_hl(0, 'NvimTreeVertSplit', { link = 'VertSplit' })
