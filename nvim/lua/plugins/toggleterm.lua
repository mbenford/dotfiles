return {
	'akinsho/toggleterm.nvim',
	keys = { '<C-Enter>' },
	config = function()
		require('toggleterm').setup({
			shade_terminals = false,
			start_in_insert = true,
			hide_humbers = true,
			float_opts = {
				border = require('utils.ui').border_float,
				width = function()
					return math.floor(vim.o.columns * 0.8)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.8)
				end,
			},
		})

		local legendary = require('legendary')
		legendary.keymaps({
			{ '<C-Enter>', '<cmd>ToggleTerm direction=float<cr>', mode = { 'n', 't' }, description = 'Toggle terminal' },
			{ '<C-S-Enter>', '<cmd>ToggleTerm direction=horizontal<cr>', mode = { 'n', 't' }, description = 'Toggle terminal' },
			{ '<C-e>', '<C-\\><C-n>', mode = 't', description = '' },
		})

		legendary.autocmds({
			{ 'TermOpen', 'setlocal signcolumn=no', opts = { pattern = 'term://*' } },
		})
	end,
}
