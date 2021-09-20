vim.g.onedark_italic_comment = 0
vim.cmd([[
	colorscheme onedark
	hi! link Pmenu NvimTreeNormal
	hi GitSignsChange guifg=#d19a66
	hi LspDiagnosticsUnderlineError gui=undercurl guisp=#993939
	hi LspDiagnosticsUnderlineWarning gui=undercurl guisp=#93691d
	hi LspDiagnosticsUnderlineHint gui=undercurl guisp=#8a3fa0
	hi LspDiagnosticsUnderlineInformation gui=undercurl guisp=#2b6f77
]])
