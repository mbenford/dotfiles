set encoding=utf-8
set termguicolors
set guicursor=
set wildmenu wildmode=full
set number relativenumber
set colorcolumn=120
set hidden
set shortmess-=S
set scrolloff=10
set sidescroll=1
set sidescrolloff=10
set title
set splitbelow
set splitright
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set ttimeoutlen=0
set virtualedit=all
set laststatus=2
set smartindent
set smarttab
set incsearch
set nohlsearch
set nocompatible
set noshowmode
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-expand-region'
Plug 'mg979/vim-visual-multi'
Plug 'vimwiki/vimwiki'
call plug#end()

syntax on
colorscheme onedark

let mapleader="\<Space>"
let g:airline_theme='violet'
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections=1
let g:airline_section_z=airline#section#create(['%3p%% ', '%3l:%-3v'])
let g:airline#extensions#tabline#enabled=1

let NERDTreeDirArrows=1
let NERDTreeShowHidden=1

nnoremap <C-t> :NERDTreeToggle %<CR>
nnoremap <silent> <Leader>f :Files<CR>

augroup CUSTOM
	autocmd!
	autocmd FileType markdown setlocal spell
	autocmd FileType gitcommit setlocal spell
	autocmd FileType markdown setlocal complete+=kspell
	autocmd FileType gitcommit setlocal complete+=kspell
augroup END

