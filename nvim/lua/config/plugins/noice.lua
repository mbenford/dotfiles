return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		views = {
			cmdline_input = {
				view = "cmdline_popup",
				relative = "cursor",
				anchor = "auto",
				position = { row = 2, col = 2 },
				size = { min_width = 30, width = "auto", height = "auto" },
			},
		},
		presets = {
			command_palette = {
				views = {
					cmdline_popup = {
						position = {
							row = 2,
						},
					},
					cmdline_popupmenu = {
						position = {
							row = 5,
						},
					},
				},
			},
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
	},
}
