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
	}
	if server_opts[server.name] then
		server_opts[server.name](opts)
	end

	server:setup(opts)
	vim.cmd([[do User LspAttachBuffers]])
end)
