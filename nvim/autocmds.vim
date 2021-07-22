augroup CUSTOM
	autocmd!
	autocmd FocusLost * silent! wa
	autocmd FileType markdown setlocal spell spelllang=en_us,pt_br
	autocmd FileType gitcommit setlocal spell spelllang=en_us,pt_br
	autocmd FileType markdown setlocal complete+=kspell
	autocmd FileType gitcommit setlocal complete+=kspell
augroup END
