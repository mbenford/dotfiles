local lsp_installer = require'nvim-lsp-installer'
lsp_installer.settings{
	ui = {
		icons = {
			server_installed = ' ',
			server_pending = ' ',
			server_uninstalled = ' ',
		},
	},
}

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	}
	server:setup(opts)
	vim.cmd[[do User LspAttachBuffers]]
end)
