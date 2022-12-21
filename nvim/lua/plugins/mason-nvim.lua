require('mason').setup({
	ui = {
		border = require('utils.ui').border_float,
		icons = {
			package_installed = ' ',
			package_pending = ' ',
			package_uninstalled = ' ',
		},
	},
})
