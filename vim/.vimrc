" plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'joshdick/onedark.vim'
call plug#end()

" turn off vi compatibility
set nocompatible

" set encoding
set encoding=utf-8

" disable delay on escape
set ttimeoutlen=0

" enable virtual editing
set virtualedit=all

" show line numbers
set number relativenumber

" show file stats
set ruler

" show status bar
set laststatus=2

" set default encoding
set encoding=utf-8

" set tabstop
set tabstop=2

" enable mouse support
set ttymouse=xterm2
set mouse=a

" disable show mode
set noshowmode

" disable changing window title
set notitle

" highlight search terms
set hlsearch

" change split direction
set splitbelow
set splitright

" turn on syntax highlighting
syntax on

" set colorscheme
colorscheme onedark

" set background as transparent
highlight Normal ctermbg=NONE

" airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_z = airline#section#create(['%3p%% ', '%3l:%-3v'])

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1

" keybindings
nnoremap <C-j> :wincmd h<CR>
nnoremap <C-k> :wincmd j<CR>
nnoremap <C-i> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <C-n> :NERDTreeToggle %<CR>

nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR>
