return {
	"echasnovski/mini.files",
	version = false,
	opts = {
		mappings = {
			go_in_plus = "<CR>",
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
	end,
}
