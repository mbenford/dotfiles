require('toggleterm').setup({
	shade_terminals = false,
})

local map = require('utils.map').map
map('n', '<leader><cr>', '<cmd>ToggleTerm<cr>')

vim.cmd([[
	au TermOpen term://* setlocal signcolumn=no nonumber norelativenumber
]])
