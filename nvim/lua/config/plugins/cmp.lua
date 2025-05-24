return {
	"hrsh7th/nvim-cmp",
	enabled = true,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"zbirenbaum/copilot-cmp",
		"xzbdmw/colorful-menu.nvim",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path", keyword_length = 3 },
				{ name = "buffer", keyword_length = 3 },
				{ name = "copilot", group_index = 2 },
				{ name = "lazydev", group_index = 0 },
			}),
			completion = {
				autocomplete = {
					cmp.TriggerEvent.TextChanged,
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				["<C-s>"] = cmp.mapping.complete({
					config = {
						sources = {
							{ name = "luasnip" },
						},
					},
				}),
			}),
			formatting = {
				fields = { "kind", "abbr" },
				format = function(entry, item)
					local hl = require("colorful-menu").cmp_highlights(entry)
					if hl ~= nil then
						item.abbr = hl.text
						item.abbr_hl_group = hl.highlights
					end

					item.kind = require("utils.ui").lsp_icons[item.kind] or " "
					return item
				end,
				expandable_indicator = false,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					function(a, b)
						if a.source.name == "copilot" and b.source.name ~= "copilot" then
							return false
						end
						if b.copilot == "copilot" and a.source.name ~= "copilot" then
							return true
						end
					end,
					cmp.config.compare.recently_used,
					cmp.config.compare.score,
					cmp.config.compare.locality,
					cmp.config.compare.offset,
					cmp.config.compare.order,
				},
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			preselect = cmp.PreselectMode.None,
			window = {
				completion = cmp.config.window.bordered({ winhighlight = "CursorLine:Visual,Search:None" }),
				documentation = cmp.config.window.bordered({ winhighlight = "CursorLine:Visual,Search:None" }),
			},
		})
	end,
}
