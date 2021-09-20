local map = require'utils'.map
vim.g.mapleader = ' '

map{'n', '<home>', '^'}
map{'n', '<end>', '$'}
map{'n', '<', '<gv'}
map{'n', '>', '>gv'}
map{'n', 'U', '<C-R>'}
map{'n', 'd', '"_d'}

map{'n', '<leader>w', ':wa<cr>'}
map{'n', '<leader>x', ':bd<cr>'}
map{'n', '<leader>q', ':qa<cr>'}
map{'', '<leader>d', 'Y`]p'}
map{'n', '<leader>i', 'i<space><esc>r'}
map{'n', '<leader>o', 'mao<esc>`a'}
map{'n', '<leader>O', 'maO<esc>`a'}
map{'v', '<leader>y', '"+y'}
map{'v', '<leader>Y', '"+Y'}
map{'n', '<C-j>', ':bprevious<cr>'}
map{'n', '<C-k>', ':bnext<cr>'}
map{'n', '<M-h>', '<C-W>h'}
map{'n', '<M-j>', '<C-W>j'}
map{'n', '<M-k>', '<C-W>k'}
map{'n', '<M-l>', '<C-W>l'}

map{'n', '<M-H>', ':vertical resize -2<cr>'}
map{'n', '<M-J>', ':resize -2<cr>'}
map{'n', '<M-K>', ':resize +2<cr>'}
map{'n', '<M-L>', ':vertical resize +2<cr>'}


--nnoremap <silent> <C-down> :m+1<CR>
--nnoremap <silent> <C-up> :m-2<CR>

map{'c', '<expr><up>', 'pumvisible() ? "<left>" : "<up>"'}
map{'c', '<expr><down>', 'pumvisible() ? "<right>" : "<down>"'}
--cnoremap <expr><Down> pumvisible() ? "\<Right>" : "\<Down>"



