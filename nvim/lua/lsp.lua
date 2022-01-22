local map = require'utils.map'
map.n{'<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>'}
map.n{'<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>'}
map.n{'<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>'}
map.n{'<leader>vs', '<cmd>lua vim.lsp.buf.signature_help()<cr>'}

vim.cmd[[
aug LSP
	au!
	au CursorHold  * silent! lua vim.lsp.buf.document_highlight()
	au CursorHoldI * silent! lua vim.lsp.buf.document_highlight()
	au CursorMoved * silent! lua vim.lsp.buf.clear_references()
aug END
]]
