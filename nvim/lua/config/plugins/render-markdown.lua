return {
	"MeanderingProgrammer/render-markdown.nvim",
	enabled = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	ft = { "markdown", "Avante", "copilot-chat", "codecompanion" },
	opts = {
		file_types = { "markdown", "Avante", "copilot-chat", "codecompanion" },
		heading = {
			width = "block",
			min_width = tonumber(vim.o.colorcolumn),
			position = "inline",
			icons = { "▊" },
		},
		code = {
			width = "block",
			min_width = tonumber(vim.o.colorcolumn),
			left_pad = 1,
			right_pad = 1,
			language_pad = 1,
		},
	},
}
