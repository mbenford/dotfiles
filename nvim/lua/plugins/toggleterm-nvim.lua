require('toggleterm').setup({
	shade_terminals = false,
})

local legendary = require('legendary')
legendary.bind_keymaps({
	{ '<leader><cr>', '<cmd>ToggleTerm<cr>', description = '' },
})
legendary.bind_autocmds({
	{ 'TermOpen', 'setlocal signcolumn=no nonumber norelativenumber', opts = { pattern = 'term://*' } },
})
