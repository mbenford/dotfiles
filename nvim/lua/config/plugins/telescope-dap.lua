return {
	"nvim-telescope/telescope-dap.nvim",
	enabled = false,
	lazy = true,
	dependencies = {
		"nvim-dap",
		"telescope.nvim",
		"nvim-treesitter",
	},
	config = function()
		require("telescope").load_extension("dap")
	end,
}
