vim.cmd[[
aug MY_AUTOCMDS
	au!
	au FocusLost * silent! wa
	au FileType markdown setlocal spell spelllang=en_us,pt_br
	au FileType gitcommit setlocal spell spelllang=en_us,pt_br
	au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
	au FileType help setlocal signcolumn=no nonumber norelativenumber
	au VimResized * wincmd =
aug END
]]
