local lazy = require('legendary.toolbox').lazy
require('legendary').autocmds({
	{
		name = 'Custom',
		clear = true,
		{ 'FocusLost', 'silent! wa' },
		{ 'TextYankPost', lazy(vim.highlight.on_yank, { higroup = 'TextYank', timeout = 150 }) },
		{ 'VimResized', lazy(vim.api.nvim_command, 'wincmd =') },
		{
			{ 'BufEnter', 'BufWritePost' },
			function(args)
				local bufinfo = vim.fn.getbufinfo(args.buf)
				if #bufinfo ~= 1 then
					return
				end

				local buffer = bufinfo[1]
				if buffer.listed == 0 then
					return
				end

				local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
				vim.opt.titlestring = string.format('%s | Neovim', cwd)
			end,
		},
	},
})
