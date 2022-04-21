local lsp_installer = require('nvim-lsp-installer')
lsp_installer.settings({
	ui = {
		icons = {
			server_installed = ' ',
			server_pending = ' ',
			server_uninstalled = ' ',
		},
	},
})

local server_opts = {
	sumneko_lua = function(opts)
		opts.settings = {
			diagnostics = {
				globals = { 'vim' },
			},
			telemetry = {
				enable = false,
			},
		}
	end,
}

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		handlers = {
			['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = require('utils.ui').border_float }),
		},
	}
	if server_opts[server.name] then
		server_opts[server.name](opts)
	end

	opts.on_attach = function(client)
		local legendary = require('legendary')
		legendary.bind_keymaps({
			{ 'K', vim.lsp.buf.hover, opts = { buffer = true }, description = '' },
			{ '<leader>lh', vim.lsp.buf.signature_help, opts = { buffer = true }, description = '' },
			{ '<leader>lf', vim.lsp.buf.formatting_seq_sync, opts = { buffer = true }, description = '' },
			{ '<leader>rr', vim.lsp.buf.rename, opts = { buffer = true }, description = '' },
		})

		if client.resolved_capabilities.document_highlight then
			legendary.bind_autocmds({
				{ { 'CursorHold', 'CursorHoldI' }, vim.lsp.buf.document_highlight, opts = { buffer = 0 } },
				{ 'CursorMoved', vim.lsp.buf.clear_references, opts = { buffer = 0 } },
			})
		end

		if client.resolved_capabilities.document_formatting then
			legendary.bind_autocmds({
				{ 'BufWritePre', vim.lsp.buf.formatting_seq_sync, opts = { buffer = 0 } },
			})
		end
	end

	server:setup(opts)
end)
