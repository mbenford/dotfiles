local M = {}

function M.setup_server(server)
	local opts = {
		capabilities = require('cmp_nvim_lsp').default_capabilities(),
		handlers = {
			['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
		},
		on_attach = function(client, bufnr)
			local lazy = require('legendary.toolbox').lazy
			local legendary = require('legendary')

			legendary.keymaps({
				{ 'K', vim.lsp.buf.hover, opts = { buffer = bufnr }, description = 'LSP Hover' },
				{ '<C-k>', vim.lsp.buf.signature_help, opts = { buffer = bufnr }, description = 'LSP Signature Help' },
				{ '<leader>rr', vim.lsp.buf.rename, opts = { buffer = bufnr }, description = 'LSP Rename' },
				{ '<leader>la', vim.lsp.buf.code_action, description = 'LSP Code Action' },
				{ '<leader>lh', lazy(vim.lsp.inlay_hint, 0, nil), opts = { buffer = bufnr }, description = 'LSP Inlay Hints' },
				{ '<leader>l?', '<Cmd>LspInfo<CR>', description = 'LSP Info' },
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
		end,
	}

	local ok, server_opts = pcall(require, 'config.language-servers.' .. server)
	if ok then
		opts = vim.tbl_deep_extend('force', opts, server_opts)
	end
	return opts
end

return M
