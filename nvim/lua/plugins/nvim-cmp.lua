local cmp = require('cmp')
cmp.setup({
	sources = {
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path', keyword_length = 5 },
		{ name = 'buffer', keyword_length = 5 },
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	documentation = true,
	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	formatting = {
		format = function(entry, item)
			item.menu = ({
				buffer = '[Buffer]',
				path = '[Path]',
				nvim_lsp = '[LSP]',
				vsnip = '[Snippet]',
				nvim_lua = '[API]',
			})[entry.source.name]
			return item
		end,
	},
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})
