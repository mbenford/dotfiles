return {
	'williamboman/mason.nvim',
	dependencies = {
		'mason-lspconfig.nvim',
	},
	config = {
		ui = {
			border = require('utils.ui').border_float,
			icons = {
				package_installed = ' ',
				package_pending = ' ',
				package_uninstalled = ' ',
			},
		},
	},
}
