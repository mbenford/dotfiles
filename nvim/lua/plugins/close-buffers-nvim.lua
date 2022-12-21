local close_buffers = require('close_buffers')
close_buffers.setup({
	preserve_window_layout = { 'this', 'nameless' },
})

local lazy = require('legendary.toolbox').lazy
require('legendary').keymaps({
	{ '<leader>q<Space>', lazy(close_buffers.delete, { type = 'this' }), description = '' },
	{ '<leader>qo', lazy(close_buffers.delete, { type = 'other' }), description = '' },
	{ '<leader>qa', lazy(close_buffers.delete, { type = 'all' }), description = '' },
})
