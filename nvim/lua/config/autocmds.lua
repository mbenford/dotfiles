local lazy = require("legendary.toolbox").lazy
require("legendary").autocmds({
	{
		name = "Custom",
		clear = true,
		{ "FocusLost", "silent! wa" },
		{ "TextYankPost", lazy(vim.highlight.on_yank, { higroup = "TextYank", timeout = 150 }) },
		{ "VimResized", lazy(vim.cmd.wincmd, "=") },
		{
			{ "BufEnter", "BufWritePost" },
			function(args)
				local bufinfo = vim.fn.getbufinfo(args.buf)
				if #bufinfo ~= 1 then
					return
				end

				local buffer = bufinfo[1]
				if buffer.listed == 0 then
					return
				end

				local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				vim.opt.titlestring = string.format("%s - nvim", cwd)
			end,
		},
		{
			"BufWinEnter",
			function(event)
				local filetype = vim.bo[event.buf].filetype
				local file_path = event.match

				if file_path:match("/doc/") == nil then
					return
				end

				if filetype ~= "help" and filetype ~= "man" and filetype ~= "markdown" then
					return
				end

				local help_win = vim.api.nvim_get_current_win()
				local popup_id = require("detour").Detour()
				if popup_id then
					require("detour.features").CloseOnLeave(popup_id)
					vim.api.nvim_win_close(help_win, false)
					vim.api.nvim_win_set_config(popup_id, {
						title = string.format(" %s ", vim.fn.fnamemodify(file_path, ":t")),
						title_pos = "center",
					})
				end
			end,
			opts = { pattern = "*" },
		},
	},
})
