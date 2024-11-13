local lazy = require("utils.lazy")

vim.api.nvim_create_augroup("Custom", { clear = true })

-- Saves all modified buffers when Neovim loses focus
vim.api.nvim_create_autocmd("FocusLost", {
	group = "Custom",
	command = "silent! wa",
})

-- Resizes splits when the Neovim window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = "Custom",
	command = "wincmd =",
})

-- Creates a highlight effect when text is yanked (copied)
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "Custom",
	callback = lazy(vim.highlight.on_yank, { higroup = "TextYank", timeout = 150 }),
})

-- Adds a buffer-local keybinding 'q' to close some windows based on their file type
vim.api.nvim_create_autocmd("FileType", {
	group = "Custom",
	pattern = "help,qf,vim",
	callback = lazy.require("which-key", "add", {
		{ "q", "<C-w>q", buffer = true, desc = "Close window" },
	}),
})

-- Updates the window title
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = "Custom",
	callback = function(args)
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
})

-- Opens help/man/markdown files in a floating window
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = custom,
	pattern = "*",
	callback = function(event)
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
})
