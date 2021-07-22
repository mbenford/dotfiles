call plug#begin(stdpath('data') . '/plugged')
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-expand-region'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-highlightedyank'
Plug 'chaoren/vim-wordmotion'
Plug 'wellle/targets.vim'
Plug 'fatih/vim-go'
call plug#end()

" airline
let g:airline_theme='violet'
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections=1
let g:airline_section_z=airline#section#create(['%3p%% ', '%3l:%-3v'])
let g:airline#extensions#tabline#enabled=1

" NERDTree
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1

" fzf
let g:fzf_layout = { 'down': '40%' }
let g:fzf_files_options = '--no-exact --tiebreak=end --prompt="> "'

" highlightedyank
let g:highlightedyank_highlight_duration = 300
