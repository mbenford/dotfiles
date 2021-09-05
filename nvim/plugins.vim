call plug#begin(stdpath('data') . '/plugged')
" syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" IDE-like features
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'folke/trouble.nvim'

" theme
Plug 'navarasu/onedark.nvim'

" fuzzy search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" UI
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'ntpeters/vim-better-whitespace'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'

" languages
Plug 'fatih/vim-go', { 'for': 'go' }

" editing
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'

" navigation
Plug 'easymotion/vim-easymotion'
Plug 'chaoren/vim-wordmotion'

" misc
Plug 'nvim-lua/plenary.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'tpope/vim-eunuch'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-expand-region'
call plug#end()

" load plugin-specific configuration
let s:plugins_folder = stdpath('config') . '/plugins'

for s:fpath in split(globpath(s:plugins_folder, '*.vim'), '\n')
	execute 'source' s:fpath
endfor

for s:fpath in split(globpath(s:plugins_folder, '*.lua'), '\n')
	execute 'luafile' s:fpath
endfor
