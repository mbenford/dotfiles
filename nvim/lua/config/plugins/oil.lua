return {
	"stevearc/oil.nvim",
	enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		keymaps = {
			["q"] = "actions.close",
		},
	},
	config = function(_, opts)
		local oil = require("oil")
		oil.setup(opts)

		require("legendary").keymaps({
			{
				"<Leader>ee",
				function()
					oil.open(vim.fn.getcwd())
				end,
				description = "",
			},
			{ "<Leader>ef", oil.open, description = "" },
		})
	end,
}
