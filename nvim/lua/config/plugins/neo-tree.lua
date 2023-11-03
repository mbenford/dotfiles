return {
	'nvim-neo-tree/neo-tree.nvim',
	branch = 'v3.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	opts = {
		enable_normal_mode_for_inputs = true,
		popup_border_style = 'rounded',
		use_popups_for_input = false,
		window = {
			position = 'float',
		},
	},
	config = function(_, opts)
		require('neo-tree').setup(opts)

		require('legendary').keymaps({
			{ '<Leader>ee', '<Cmd>Neotree toggle<CR>' },
			{ '<Leader>ef', '<Cmd>Neotree reveal<CR>' },
			{ '<Leader>eb', '<Cmd>Neotree toggle buffers<CR>' },
			{ '<Leader>eg', '<Cmd>Neotree toggle git_status<CR>' },
		})
	end,
}
