return {
	'mhartington/formatter.nvim',
	enabled = false,
	event = { 'BufRead', 'InsertEnter' },
	config = function()
		require('formatter').setup({
			filetype = {
				css = { require('formatter.filetypes.css').prettier },
				go = { require('formatter.filetypes.go').goimports },
				html = { require('formatter.filetypes.html').prettier },
				javascript = { require('formatter.filetypes.javascript').prettier },
				javascriptreact = { require('formatter.filetypes.javascriptreact').prettier },
				json = { require('formatter.filetypes.json').prettier },
				lua = { require('formatter.filetypes.lua').stylua },
				markdown = { require('formatter.filetypes.markdown').prettier },
				python = { require('formatter.filetypes.python').black },
				rust = { require('formatter.filetypes.rust').rustfmt },
				sh = { require('formatter.filetypes.sh').shfmt },
				terraform = { require('formatter.filetypes.terraform').terraformfmt },
				typescript = { require('formatter.filetypes.typescript').prettier },
				typescriptreact = { require('formatter.filetypes.typescriptreact').prettier },
				['*'] = { require('formatter.filetypes.any').remove_trailing_whitespace },
			},
		})

		local legendary = require('legendary')
		legendary.keymaps({
			{ '<Leader><Leader>f', '<Cmd>Format<CR>', description = '' },
		})
		legendary.autocmds({
			{
				name = 'Formatter',
				clear = true,
				{ 'BufWritePost', 'FormatWrite' },
			},
		})
	end,
}
