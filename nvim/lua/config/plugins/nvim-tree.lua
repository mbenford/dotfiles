return {
	'nvim-tree/nvim-tree.lua',
	enabled = false,
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	keys = { '<Leader>e' },
	opts = {
		update_cwd = true,
		filters = {
			custom = { '^\\.git$' },
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
	},
	config = function(_, opts)
		require('nvim-tree').setup(opts)

		local api = require('nvim-tree.api')
		local Event = api.events.Event

		api.events.subscribe(Event.FileCreated, function(file)
			vim.cmd('edit ' .. file.fname)
		end)

		require('legendary').keymaps({
			{ '<Leader>ee', api.tree.toggle, description = 'Toggles NvimTree' },
			{ '<Leader>ef', api.tree.focus, description = 'Focus NvimTree' },
		})
	end,
}
