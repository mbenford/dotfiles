return {
	"OXY2DEV/markview.nvim",
	enabled = false,
	ft = { "markdown" },
	opts = {
		preview = {
			filetypes = { "markdown", "copilot-chat" },
		},
		code_blocks = {
			icons = "mini",
		},
	},
	config = function(_, opts)
		opts.headings = require("markview.presets").headings.marker
		require("markview").setup(opts)
	end,
}
