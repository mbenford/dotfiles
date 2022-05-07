require('Comment').setup({
	mappings = {
		basic = false,
		extra = false,
		extended = false,
	},
	ignore = '^$',
})

require('legendary').bind_keymaps({
	{ '<leader>cc', '<cmd>lua require"Comment.api".call("toggle_current_linewise_op")<cr>g@$' },
	{ '<leader>cb', '<cmd>lua require"Comment.api".call("toggle_current_blockwise_op")<cr>g@$' },
	{ '<leader>c', '<cmd>lua require"Comment.api".call("toggle_linewise_op")<cr>g@' },
	{ '<leader>cc', '<esc><cmd>lua require"Comment.api".toggle_linewise_op(vim.fn.visualmode())<cr>', mode = { 'x' } },
	{ '<leader>cb', '<esc><cmd>lua require"Comment.api".toggle_blockwise_op(vim.fn.visualmode())<cr>', mode = { 'x' } },
	{ '<leader>co', '<cmd>lua require"Comment.api".insert_linewise_above()<cr>' },
	{ '<leader>ca', '<cmd>lua require"Comment.api".insert_linewise_eol()<cr>' },
})
