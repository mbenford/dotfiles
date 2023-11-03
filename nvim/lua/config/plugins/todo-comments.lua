return {
	'folke/todo-comments.nvim',
	event = 'BufRead',
	opts = {
		signs = false,
		highlight = {
			keyword = 'fg',
			after = '',
		},
	},
	config = function (_, opts)
		local todo = require('todo-comments')
		todo.setup(opts)

		require('legendary').keymaps({
			{ '[t', todo.jump_prev, opts = { buffer = true }, description = 'Go to prev todo comment' },
			{ ']t', todo.jump_next, opts = { buffer = true }, description = 'Go to next todo comment' },
		})
	end
}
