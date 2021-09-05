let g:nvim_tree_ignore = ['.git', '.idea', '.vscode', 'node_modules', '.cache']
let g:nvim_tree_special_files = { 'Makefile': 1 }
let g:nvim_tree_git_hl = 1
let g:nvim_tree_show_icons = {
  \ 'git': 0,
  \ 'folders': 1,
  \ 'files': 1,
  \ 'folder_arrows': 1,
  \ }
let g:nvim_tree_icons = {
	\ 'default': '',
	\ 'symlink': '',
\ }
lua << EOF
require('nvim-tree.view').View.winopts.signcolumn = 'no'
EOF
