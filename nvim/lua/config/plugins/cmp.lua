
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
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					if item.abbr:sub(#item.abbr) == "~" then
						item.abbr = item.abbr:sub(1, -2)
					end
					item.kind = require("utils.ui").lsp_icons[item.kind] or " "
					item.menu = string.format("%10s", entry.source.name:upper():gsub("NVIM_", ""))
					return item
				end,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					function(entry1, entry2)
						if entry1.source.name == "copilot" and entry2.source.name ~= "copilot" then
							return false
						elseif entry2.copilot == "copilot" and entry1.source.name ~= "copilot" then
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
				completion = cmp.config.window.bordered({
					winhighlight = "CursorLine:Visual,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					winhighlight = "CursorLine:Visual,Search:None",
				}),
			},
		})
	end,
}
