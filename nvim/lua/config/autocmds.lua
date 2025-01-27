local lazy = require("utils.lazy")

local group = vim.api.nvim_create_augroup("Custom", { clear = true })

-- Saves all modified buffers when Neovim loses focus
vim.api.nvim_create_autocmd("FocusLost", {
	group = group,
	command = "silent! wa",
})

-- Resizes splits when the Neovim window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	command = "wincmd =",
})

-- Creates a highlight effect when text is yanked (copied)
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = lazy(vim.highlight.on_yank, { higroup = "TextYank", timeout = 200 }),
})

-- Adds a buffer-local keybinding 'q' to close some windows based on their file type
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = { "help", "qf", "vim", "checkhealth" },
	callback = function(event)
		require("which-key").add({ "q", "<C-w>q", buffer = event.buf, desc = "Close window" })
	end,
})

-- Opens help files in a floating window
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = group,
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

		local curr_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_close(curr_win, false)

		local win = require("snacks").win.new({
			buf = event.buf,
			border = "rounded",
			width = 120,
			backdrop = false,
			title = " HELP ",
			title_pos = "center",
			footer = string.format(" %s ", vim.fn.fnamemodify(file_path, ":~")),
			footer_pos = "center",
			wo = {
				wrap = true,
			},
		})
		win:add_padding()
		win:update()
		vim.api.nvim_create_autocmd("WinEnter", {
			group = win.augroup,
			callback = function()
				win:close()
			end,
		})
	end,
})
