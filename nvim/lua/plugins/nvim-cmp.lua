local cmp = require('cmp')
cmp.setup({
	sources = cmp.config.sources({
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path', keyword_length = 5 },
		{ name = 'buffer', keyword_length = 5 },
	}),
	documentation = true,
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i' , 'c' }),
		['<C-p>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable,
		['<C-e>'] = cmp.mapping.close({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	},
	formatting = {
		format = function(entry, item)
			item.menu = ({
				buffer = '[Buffer]',
				path = '[Path]',
				nvim_lsp = '[LSP]',
				luasnip = '[Snippet]',
				nvim_lua = '[API]',
			})[entry.source.name]
			return item
		end,
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})
