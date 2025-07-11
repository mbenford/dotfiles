return {
	"MeanderingProgrammer/render-markdown.nvim",
	enabled = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	ft = { "markdown", "copilot-chat" },
	opts = {
		anti_conceal = {
			enabled = true,
		},
		file_types = { "markdown", "copilot-chat" },
		render_modes = { "n", "V", "t", "i", "c" },
		heading = {
			border = true,
			position = "inline",
			icons = {
				"❱ ",
				"❱❱ ",
				"❱❱❱ ",
				"❱❱❱❱ ",
				"❱❱❱❱❱ ",
				"❱❱❱❱❱❱ ",
			},
		},
		code = {
			left_pad = 1,
			right_pad = 1,
			language_pad = 1,
		},
		dash = {},
		win_options = { concealcursor = { rendered = "n" } },
		completions = { blink = { enbaled = true } },
	},
}
