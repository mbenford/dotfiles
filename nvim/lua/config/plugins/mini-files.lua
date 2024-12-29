return {
	"echasnovski/mini.files",
	version = "*",
	opts = {
		options = {
			permanent_delete = false,
		},
		mappings = {
			go_in = "<Right>",
			go_in_plus = "<CR>",
			go_out = "<Left>",
			go_out_plus = "-",
			synchronize = "<Leader>w",
		},
		windows = {
			width_focus = 30,
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowUpdate",
			callback = function(args)
				local config = vim.api.nvim_win_get_config(args.data.win_id)
				config.border = "rounded"
				config.title_pos = "center"
				config.height = 10
				config.footer = string.format(" %d ", vim.api.nvim_buf_line_count(args.data.buf_id))
				config.footer_pos = "center"

				if config.title[#config.title][1] ~= " " then
					table.insert(config.title, { " ", "NormalFloat" })
				end
				if config.title[1][1] ~= " " then
					table.insert(config.title, 1, { " ", "NormalFloat" })
				end

				vim.api.nvim_win_set_config(args.data.win_id, config)
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				require("snacks").rename.on_rename_file(event.data.from, event.data.to)
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
