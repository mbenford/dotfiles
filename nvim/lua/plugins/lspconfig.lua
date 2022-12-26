return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'mason.nvim',
	},
	config = function()
		local server_opts = {
			['cssls'] = {
				filetypes = { 'css', 'scss', 'less', 'pcss' },
			},
			['jsonls'] = {
				settings = {
					json = {
						schemas = require('schemastore').json.schemas(),
						validate = { enable = true },
					},
				},
			},
			['summeko_lua'] = {
				settings = {
					diagnostics = {
						globals = { 'vim' },
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		for _, server in pairs(require('mason-lspconfig').get_installed_servers()) do
			require('lspconfig')[server].setup(require('lsp').setup_server(server_opts[server] or {}))
		end

		require('lspconfig.ui.windows').default_options.border = require('utils.ui').border_float

		local hl = require('utils.highlight')
		hl.set('LspInfoBorder', { link = 'FloatBorder' })
	end,
}
