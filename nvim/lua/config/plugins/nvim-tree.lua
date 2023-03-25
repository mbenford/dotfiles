return {
	'kyazdani42/nvim-tree.lua',
	dependencies = {
		'nvim-web-devicons',
	},
	keys = { '<Leader>e' },
	config = function ()
		require('nvim-tree').setup({
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
		})

		require('nvim-tree.events').on_file_created(function(file)
			vim.cmd('edit ' .. file.fname)
		end)

		require('legendary').keymaps({
			{ '<Leader>e', '<Cmd>NvimTreeToggle<CR>', description = 'Toggles NvimTree' },
		})
 end
}
