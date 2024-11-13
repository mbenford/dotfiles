return {
	"echasnovski/mini.files",
	version = false,
	opts = {
		options = {
			permanent_delete = false,
		},
		mappings = {
			go_in = "<Right>",
			go_in_plus = "<CR>",
			go_out = "<Left>",
			go_out_plus = "-",
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id
				local config = vim.api.nvim_win_get_config(win_id)
				config.border = "rounded"
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})
	end,
	keys = {
		{
			"<Leader>ee",
			function()
				require("mini.files").open(nil, false)
			end,
			desc = "Open Mini Files",
		},
		{
			"<Leader>ef",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0))
			end,
			desc = "Open Mini Files on current file",
		},
	},
}
