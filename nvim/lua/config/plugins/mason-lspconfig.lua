return {
	'williamboman/mason-lspconfig.nvim',
	event = { 'BufRead', 'InsertEnter' },
	opts = {
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
			'lua_ls',
			'terraformls',
			'tsserver',
			'yamlls',
		},
	},
}
