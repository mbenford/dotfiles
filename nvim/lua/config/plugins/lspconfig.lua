return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'mason.nvim',
	},
	event = { 'BufRead', 'InsertEnter' },
	config = function()
		for _, server in pairs(require('mason-lspconfig').get_installed_servers()) do
			require('lspconfig')[server].setup(require('config.lsp').setup_server(server))
		end

		require('lspconfig.ui.windows').default_options.border = 'rounded'
		local hl = require('utils.highlight')
		hl.set('LspInfoBorder', { link = 'FloatBorder' })
	end,
}
