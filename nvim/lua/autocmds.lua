vim.cmd[[
augroup MY_AUTOCMDS
	au!
	au FocusLost * silent! wa
	au FileType markdown setlocal spell spelllang=en_us,pt_br
	au FileType gitcommit setlocal spell spelllang=en_us,pt_br
	au FileType markdown setlocal complete+=kspell
	au FileType gitcommit setlocal complete+=kspell
	au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
	au FileType fzf setlocal signcolumn=no nonumber norelativenumber
	au FileType help setlocal signcolumn=no nonumber norelativenumber
	au BufNewFile,BufRead *.pcss setlocal filetype=scss
	au VimResized * wincmd =
augroup END
]]
