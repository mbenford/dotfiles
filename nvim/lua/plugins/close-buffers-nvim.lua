require('close_buffers').setup({
	preserve_window_layout = { 'this', 'nameless' },
})

require('legendary').bind_keymaps({
	{ '<leader>qb', '<cmd>BDelete this<cr>', description = '' },
	{ '<leader>qo', '<cmd>BDelete other<cr>', description = '' },
	{ '<leader>qa', '<cmd>BDelete all<cr>', description = '' },
})
