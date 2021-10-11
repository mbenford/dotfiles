local cmp = require'cmp'
cmp.setup {
	sources = {
		{ name = 'buffer' },
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	},
	documentation = false,
	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		})
	},
	formatting = {
		format = function(entry, item)
			item.menu = ({
				buffer = '[B]',
				nvim_lsp = '[L]',
				vsnip = '[S]',
			})[entry.source.name]
			return item
		end
	},
	snippet = {
		expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
	},
}
