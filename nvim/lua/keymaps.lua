local map = require'map'
vim.g.mapleader = ' '

map.n{';', ':', silent = false}
map.v{';', ':', silent = false}
map.n{'<home>', '^'}
map.n{'<end>', '$'}
map.v{'<', '<gv'}
map.v{'>', '>gv'}
map.n{'U', '<C-R>'}

map.n{'<leader>w', '<cmd>wa<cr>'}
map.n{'<leader>x', '<cmd>bd<cr>'}
map.n{'<leader>q', '<cmd>qa<cr>'}
map.n{'<leader>d', 'Y`]p'}
map.v{'<leader>d', 'Y`]p'}
map.n{'<leader>i', 'i<space><esc>r'}
map.n{'<leader>o', 'mao<esc>`a'}
map.n{'<leader>O', 'maO<esc>`a'}
map.n{'<leader>y', '"+y'}
map.n{'<leader>Y', '"+Y'}
map.v{'<leader>Y', '"+Y'}
map.n{'<M-h>', '<C-W>h'}
map.n{'<M-j>', '<C-W>j'}
map.n{'<M-k>', '<C-W>k'}
map.n{'<M-l>', '<C-W>l'}

map.n{'<M-H>', '<cmd>vertical resize -2<cr>'}
map.n{'<M-J>', '<cmd>resize -2<cr>'}
map.n{'<M-K>', '<cmd>resize +2<cr>'}
map.n{'<M-L>', '<cmd>vertical resize +2<cr>'}


--nnoremap <silent> <C-down> :m+1<CR>
--nnoremap <silent> <C-up> :m-2<CR>

map.c{'<up>', 'pumvisible() ? "\\<left>" : "\\<up>"', expr = true, silent = false}
map.c{'<down>', 'pumvisible() ? "\\<right>" : "\\<down>"', expr = true, silent = false}

map.n{'<F2>', '<cmd>lua require"renamer".rename()<cr>'}
