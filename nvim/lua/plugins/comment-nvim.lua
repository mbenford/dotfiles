require('Comment').setup({
	mappings = {
		basic = false,
		extra = false,
		extended = false,
	},
	ignore = '^$',
})

local map = require('utils.map').map
map('n', '<leader>cc', '<cmd>lua require"Comment.api".call("toggle_current_linewise_op")<cr>g@$')
map('n', '<leader>cb', '<cmd>lua require"Comment.api".call("toggle_current_blockwise_op")<cr>g@$')
map('n', '<leader>c', '<cmd>lua require"Comment.api".call("toggle_linewise_op")<cr>g@')
map('v', '<leader>cc', '<esc><cmd>lua require"Comment.api".toggle_linewise_op(vim.fn.visualmode())<cr>')
map('v', '<leader>cb', '<esc><cmd>lua require"Comment.api".toggle_blockwise_op(vim.fn.visualmode())<cr>')
map('n', '<leader>co', '<cmd>lua require"Comment.api".insert_linewise_above()<cr>')
map('n', '<leader>ca', '<cmd>lua require"Comment.api".insert_linewise_eol()<cr>')
