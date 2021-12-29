vim.cmd[[
aug LSP
	au!
	au CursorHold  * silent! lua vim.lsp.buf.document_highlight()
	au CursorHoldI * silent! lua vim.lsp.buf.document_highlight()
	au CursorMoved * silent! lua vim.lsp.buf.clear_references()
aug END
]]
