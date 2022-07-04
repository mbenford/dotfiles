local servers = {
	bashls = {},
	cssls = {
		filetypes = { 'css', 'scss', 'less', 'pcss' },
	},
	cssmodules_ls = {},
	dockerls = {},
	eslint = {},
	gopls = {},
	html = {},
	jsonls = {},
	pyright = {},
	rust_analyzer = {},
	sumneko_lua = {
		settings = {
			diagnostics = {
				globals = { 'vim' },
			},
			telemetry = {
				enable = false,
			},
		},
	},
	terraformls = {},
	tsserver = {},
	yamlls = {},
}

require('nvim-lsp-installer').setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = ' ',
			server_pending = ' ',
			server_uninstalled = ' ',
		},
	},
})

for server, opts in pairs(servers) do
	require('lspconfig')[server].setup(require('lsp').setup_server(opts))
end

local lazy = require('legendary.helpers').lazy
require('legendary').bind_autocmds({
	{
		name = 'LspConfig',
		clear = true,
		{
			'FileType',
			lazy(vim.api.nvim_win_set_config, 0, { border = require('utils.ui').border_float }),
			opts = { pattern = { 'lspinfo', 'lsp-installer' } },
		},
	},
})
