local map = require'utils.map'
vim.g.mapleader = ' '

map.n{';', ':', silent = false}
map.v{';', ':', silent = false}
map.n{'<home>', '^'}
map.n{'<end>', '$'}
map.v{'<', '<gv'}
map.v{'>', '>gv'}
map.n{'U', '<C-r>'}

map.n{'<leader>w', '<cmd>wa<cr>'}
map.n{'<leader>x', '<cmd>bd<cr>'}
map.n{'<leader>qq', '<cmd>qa<cr>'}
map.n{'<leader>Q', '<cmd>qa!<cr>'}
map.n{'<leader>d', 'Y`]p'}
map.v{'<leader>d', 'Y`]p'}
map.n{'<leader>i', 'i<space><esc>r'}
map.n{'<leader>o', 'mao<esc>`a'}
map.n{'<leader>O', 'maO<esc>`a'}
map.n{'<leader>y', '"+y'}
map.n{'<leader>Y', '"+Y'}
map.v{'<leader>y', '"+y'}

map.n{'<M-h>', '<C-w>h'}
map.n{'<M-j>', '<C-w>j'}
map.n{'<M-k>', '<C-w>k'}
map.n{'<M-l>', '<C-w>l'}

map.i{'<M-h>', '<C-\\><C-n><C-w>h'}
map.i{'<M-j>', '<C-\\><C-n><C-w>j'}
map.i{'<M-k>', '<C-\\><C-n><C-w>k'}
map.i{'<M-l>', '<C-\\><C-n><C-w>l'}

map.t{'<M-h>', '<C-\\><C-n><C-w>h'}
map.t{'<M-j>', '<C-\\><C-n><C-w>j'}
map.t{'<M-k>', '<C-\\><C-n><C-w>k'}
map.t{'<M-l>', '<C-\\><C-n><C-w>l'}

map.n{'<M-H>', '<cmd>vertical resize -2<cr>'}
map.n{'<M-J>', '<cmd>resize -2<cr>'}
map.n{'<M-K>', '<cmd>resize +2<cr>'}
map.n{'<M-L>', '<cmd>vertical resize +2<cr>'}


map.c{'<up>', 'pumvisible() ? "\\<left>" : "\\<up>"', expr = true, silent = false}
map.c{'<down>', 'pumvisible() ? "\\<right>" : "\\<down>"', expr = true, silent = false}

map.n{'<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>'}
map.n{'<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>'}
map.n{'<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>'}