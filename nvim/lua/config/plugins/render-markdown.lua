return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	ft = { "markdown", "codecompanion", "Avante" },
	opts = {
		file_types = { "markdown", "codecompanion", "Avante" },
		anti_conceal = {
			enabled = true,
		},
		render_modes = { "n", "V", "t", "i", "c" },
		heading = {
			border = false,
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
		completions = { blink = { enabled = true } },
	},
}
