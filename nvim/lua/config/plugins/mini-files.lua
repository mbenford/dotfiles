return {
	"echasnovski/mini.files",
	version = false,
	keys = { "<Leader>ee", "<Leader>ef" },
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
		local mini_files = require("mini.files")
		mini_files.setup(opts)

		local lazy = require("legendary.toolbox").lazy
		require("legendary").keymaps({
			{ "<Leader>ee", lazy(mini_files.open, nil, false), description = "" },
			{
				"<Leader>ef",
				function()
					mini_files.open(vim.api.nvim_buf_get_name(0))
				end,
				description = "",
			},
		})

		require("legendary").autocmds({
			{
				name = "MiniFiles",
				clear = true,
				{
					"User",
					function(args)
						local win_id = args.data.win_id
						local config = vim.api.nvim_win_get_config(win_id)
						config.border = "rounded"
						vim.api.nvim_win_set_config(win_id, config)
					end,
					opts = {
						pattern = "MiniFilesWindowOpen",
					},
				},
			},
		})
	end,
}
