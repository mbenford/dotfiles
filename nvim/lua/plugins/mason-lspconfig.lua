return {
	'williamboman/mason-lspconfig.nvim',
	config = {
		automatic_installation = true,
		ensure_installed = {
			'bashls',
			'cssls',
			'cssmodules_ls',
			'dockerls',
			'eslint',
			'gopls',
			'html',
			'jsonls',
			'pyright',
			'rust_analyzer',
			'sumneko_lua',
			'terraformls',
			'tsserver',
			'yamlls',
		},
	}
}
