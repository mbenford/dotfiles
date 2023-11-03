return {
	'akinsho/toggleterm.nvim',
	enabled = false,
	opts = {
		shade_terminals = false,
		start_in_insert = true,
		hide_humbers = true,
		highlights = {
			FloatBorder = { link = 'FloatBorder' },
		},
		float_opts = {
			border = 'rounded',
			width = function()
				return math.floor(vim.o.columns * 0.95)
			end,
			height = function()
				return math.floor(vim.o.lines * 0.9)
			end,
		},
	},
	config = function(_, opts)
		require('toggleterm').setup(opts)

		local Terminal = require('toggleterm.terminal').Terminal
		local float_term = Terminal:new({ direction = 'float', hidden = true })

		local legendary = require('legendary')
		legendary.keymaps({
			{
				'<C-Enter>',
				function()
					float_term:toggle()
				end,
				mode = { 'n', 't' },
				description = 'Toggle float terminal',
			},
			{
				'<C-S-Enter>',
				function()
					Terminal:new({ direction = 'horizontal' }):open()
				end,
				mode = { 'n', 't' },
				description = 'Create a new terminal',
			},
		})

		legendary.autocmds({
			{ 'TermOpen', 'setlocal signcolumn=no statuscolumn=', opts = { pattern = 'term://*' } },
			{ 'BufEnter', 'startinsert', opts = { pattern = 'term://*' } },
		})
	end,
}
