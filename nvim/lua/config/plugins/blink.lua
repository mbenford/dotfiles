return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
	},
	event = "InsertEnter",
	version = "1.*",
	opts = {
		keymap = { preset = "default" },
		appearance = { nerd_font_variant = "mono" },
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
			documentation = {
				auto_show = false,
				window = {
					border = "rounded",
				},
			},
			menu = {
				max_height = 20,
				border = "rounded",
				draw = {
					align_to = "none",
					columns = {
						{ "kind_icon" },
						{ "label", gap = 1 },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								return require("utils.ui").lsp_icons[ctx.kind] or " "
							end,
						},
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "buffer", "copilot" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = -100,
					async = true,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = { enabled = false },
	},
}
