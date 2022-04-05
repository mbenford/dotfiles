local lightbulb = require('nvim-lightbulb')
lightbulb.setup({
	sign = { enabled = true },
})

local autocmd = require('utils.autocmd').augroup('nvim-lightbulb')
autocmd('CursorHold,CursorHoldI', '*', lightbulb.update_lightbulb)

vim.fn.sign_define('LightBulbSign', { text = '', texthl = 'DiagnosticWarn' })
