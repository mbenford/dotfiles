local M = {}

function M.setup_server(opts)
	local default_opts = {
		capabilities = require('cmp_nvim_lsp').default_capabilities(),
		handlers = {
			['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = require('utils.ui').border_float }),
		},
		on_attach = M.on_attach,
	}
	return vim.tbl_deep_extend('force', default_opts, opts)
end

function M.on_attach(client)
	local legendary = require('legendary')

	legendary.keymaps({
		{ 'K', vim.lsp.buf.hover, opts = { buffer = true }, description = 'LSP Hover' },
		{ '<leader>lh', vim.lsp.buf.signature_help, opts = { buffer = true }, description = 'LSP Signature Help' },
		{ '<leader>lf', vim.lsp.buf.format, opts = { buffer = true }, description = 'LSP Format' },
		{ '<leader>rr', vim.lsp.buf.rename, opts = { buffer = true }, description = 'LSP Rename' },
		{ '<leader>la', vim.lsp.buf.code_action, description = 'LSP Code Action' },
	})

	if client.supports_method('textDocument/documentHighlight') then
		legendary.autocmds({
			{
				name = 'LspDocumentHighlight',
				clear = true,
				{ { 'CursorHold', 'CursorHoldI' }, vim.lsp.buf.document_highlight, opts = { buffer = 0 } },
				{ 'CursorMoved', vim.lsp.buf.clear_references, opts = { buffer = 0 } },
			},
		})
	end
end

return M
