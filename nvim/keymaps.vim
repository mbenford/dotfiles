let mapleader="\<Space>"

nnoremap <silent> <leader>tt :NvimTreeToggle<CR>
nnoremap <silent> <leader>tf :NvimTreeFindFile<CR>
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>x :bd<CR>
nnoremap <silent> <leader>q :qall<CR>

silent !git rev-parse --is-inside-work-tree
if v:shell_error == 0
	nnoremap <silent> <leader>j :GFiles --cached --others --exclude-standard<CR>
else
	nnoremap <silent> <leader>j :Files<CR>
endif

nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>d Yp
nnoremap <silent> <leader>i i<SPACE><ESC>r
noremap <silent> <leader>y "+y
noremap <silent> <leader>Y "+Y

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <C-j> :bprevious<CR>
nnoremap <silent> <A-j> :bprevious<CR>
nnoremap <silent> <leader>o mao<ESC>`a
nnoremap <silent> <leader>O maO<ESC>`a
nnoremap <silent> <C-down> :m+1<CR>
nnoremap <silent> <C-up> :m-2<CR>
nnoremap <silent> U <C-R>
map <Home> ^
map <End> $

cnoremap <expr><Up> pumvisible() ? "\<Left>" : "\<Up>"
cnoremap <expr><Down> pumvisible() ? "\<Right>" : "\<Down>"

nnoremap <silent> <M-h>	<C-W>h
nnoremap <silent> <M-j>	<C-W>j
nnoremap <silent> <M-k>	<C-W>k
nnoremap <silent> <M-l>	<C-W>l

nnoremap <silent> <M-H>	:vertical resize -2<CR>
nnoremap <silent> <M-J>	:resize -2<CR>
nnoremap <silent> <M-K>	:resize +2<CR>
nnoremap <silent> <M-L>	:vertical resize +2<CR>

vnoremap < <gv
vnoremap > >gv

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

