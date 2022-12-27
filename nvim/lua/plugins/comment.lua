return {
	'numToStr/Comment.nvim',
	event = 'BufRead',
	config = function()
		require('Comment').setup({
			mappings = {
				basic = false,
				extra = false,
				extended = false,
			},
			ignore = '^$',
		})

		local comment = require('Comment.api')
		require('legendary').keymaps({
			{ '<leader>cc', comment.toggle.linewise.current },
			{ '<leader>cb', comment.toggle.blockwise.current },
			{ '<leader>c', comment.call('toggle.linewise', 'g@'), opts = { expr = true } },
			{
				'<leader>cc',
				function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'nx', false)
					comment.toggle.linewise(vim.fn.visualmode())
				end,
				mode = { 'x' },
			},
			{ '<leader>cb', '<Esc><Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', mode = { 'x' } },
			{ '<leader>co', '<Cmd>lua require("Comment.api").insert.linewise.above()<CR>' },
			{ '<leader>ca', '<Cmd>lua require("Comment.api").insert.linewise.eol()<CR>' },
		})
	end,
}
