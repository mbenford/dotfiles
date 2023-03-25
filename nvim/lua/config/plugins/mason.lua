return {
	'williamboman/mason.nvim',
	cmd = 'Mason',
	opts = {
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
