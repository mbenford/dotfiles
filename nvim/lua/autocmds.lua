local lazy = require('legendary.helpers').lazy
require('legendary').bind_autocmds({
	{
		name = 'Custom',
		clear = true,
		{ 'FocusLost', 'silent! wa' },
		{ 'TextYankPost', lazy(vim.highlight.on_yank, { higroup = 'TextYank', timeout = 150 }) },
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

				local name = ''
				local directory = ''
				if buffer.name == '' then
					name = '[No Name]'
					directory = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
				else
					name = vim.fn.fnamemodify(buffer.name, ':t')
					directory = vim.fn.fnamemodify(buffer.name, ':~:h')
				end
				vim.opt.titlestring = string.format('%s (%s)', name, directory)
			end,
		},
	},
})
