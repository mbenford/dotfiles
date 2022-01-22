vim.cmd([[
  imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>'
	smap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>'
]])
