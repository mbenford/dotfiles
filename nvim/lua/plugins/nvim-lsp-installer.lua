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

	opts.on_attach = function(client, _)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
				aug LSP
					au!
					au BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
				aug END
			]])
		end
	end

	server:setup(opts)
end)
