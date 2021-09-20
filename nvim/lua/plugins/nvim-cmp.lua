local cmp = require'cmp'
cmp.setup {
	sources = {
		{ name = 'buffer' },
		{ name = 'nvim_lsp' },
	},
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
				buffer = '[Buffer]',
				nvim_lsp = '[LSP]',
			})[entry.source.name]
			return item
		end
	},
}
