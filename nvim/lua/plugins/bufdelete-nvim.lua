local bufdelete = require('bufdelete')
local lazy = require('legendary.toolbox').lazy
require('legendary').keymaps({
	{ '<Leader>qw', '<C-w>q', description = 'Close window' },
	{ '<Leader>q<Space>', lazy(bufdelete.bufdelete, 0), description = 'Close current buffer' },
	{
		'<Leader>qo',
		function()
			local curr_bufnr = vim.api.nvim_get_current_buf()
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if bufnr ~= curr_bufnr then
					bufdelete.bufdelete(bufnr)
				end
			end
		end,
		description = 'Close other buffers',
	},
})
