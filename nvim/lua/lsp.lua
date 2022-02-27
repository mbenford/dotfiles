local map = require('utils.map')
map.n({ '<leader>ld', function() vim.lsp.buf.definition() end })
map.n({ '<leader>li', function() vim.lsp.buf.implementation() end })
map.n({ '<leader>lr', function() vim.lsp.buf.references() end })
map.n({ '<leader>ls', function() vim.lsp.buf.signature_help() end })
map.n({ '<leader>lh', function() vim.lsp.buf.hover() end })
map.n({ '<leader>lf', function() vim.lsp.buf.formatting_seq_sync() end })

vim.cmd([[
aug LSP
	au!
	au CursorHold  * silent! lua vim.lsp.buf.document_highlight()
	au CursorHoldI * silent! lua vim.lsp.buf.document_highlight()
	au CursorMoved * silent! lua vim.lsp.buf.clear_references()
aug END
]])
