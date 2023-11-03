return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
	},
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			sources = cmp.config.sources({
				{ name = 'nvim_lua' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'path', keyword_length = 3 },
				{ name = 'buffer', keyword_length = 3 },
				{ name = 'copilot' },
			}),
			completion = {
				autocomplete = {
					cmp.TriggerEvent.TextChanged,
				},
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
				['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
				['<C-p>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
				['<C-y>'] = cmp.config.disable,
				['<C-e>'] = cmp.mapping.close({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
				['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
			}),
			formatting = {
				fields = { 'kind', 'abbr', 'menu' },
				format = function(entry, item)
					if item.abbr:sub(#item.abbr) == '~' then
						item.abbr = item.abbr:sub(1, -2)
					end
					item.kind = require('utils.ui').lsp_icons[item.kind] or ' '
					item.menu = string.format('%10s', entry.source.name:upper():gsub('NVIM_', ''))
					return item
				end,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					cmp.config.compare.recently_used,
					cmp.config.compare.score,
					cmp.config.compare.locality,
					cmp.config.compare.offset,
					cmp.config.compare.order,
				},
			},
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			preselect = cmp.PreselectMode.None,
			window = {
				documentation = {
					border = 'rounded',
					winhighlight = 'FloatBorder:FloatBorder',
				},
			},
		})
	end,
}
