local g = vim.g
g.nvim_tree_ignore = {'.git', '.idea', '.vscode', 'node_modules', '.cache'}
g.nvim_tree_special_files = { Makefile = 1 }
g.nvim_tree_git_hl = 1
g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}
g.nvim_tree_icons = {
	default = '',
	symlink = '',
}

require'nvim-tree'.setup()
require'nvim-tree.view'.View.winopts.signcolumn = 'no'

local map = require'utils'.map
map{'n', '<leader>tt', ':NvimTreeToggle<cr>'}
map{'n', '<leader>tf', ':NvimTreeFindFile<cr>'}
