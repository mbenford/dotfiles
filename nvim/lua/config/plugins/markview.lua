return {
	"OXY2DEV/markview.nvim",
	enabled = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "markdown" },
	opts = {
		code_blocks = {
			icons = "mini",
		},
	},
	config = function(_, opts)
		opts.headings = require("markview.presets").headings.marker
		require("markview").setup(opts)
	end,
}
