call plug#begin(stdpath('data') . '/plugged')
Plug 'dstein64/vim-startuptime'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'navarasu/onedark.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'preservim/nerdcommenter'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-expand-region'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'
Plug 'chaoren/vim-wordmotion'
Plug 'wellle/targets.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
call plug#end()

lua << EOF
require'lspconfig'.gopls.setup{}
require'nvim-treesitter.configs'.setup{
	ensure_installed = {
		'go',
		'gomod',
		'python',
		'javascript',
		'json',
		'typescript',
		'tsx',
		'lua',
		'bash',
		'c',
		'cpp',
		'css',
		'scss',
		'dockerfile',
		'rust',
		'yaml',
		'toml',
	},
	highlight = {
		enable= true,
	},
}
require('gitsigns').setup{
  signs = {
    add          = {text = '▋'},
    change       = {text = '▋'},
    delete       = {text = '▋'},
    topdelete    = {text = '▋'},
    changedelete = {text = '▋'},
  },
}
require('lualine').setup{
	options = {
		theme = 'dracula',
	},
	sections = {
		lualine_x = {'filetype'},
		lualine_y = {'encoding', 'fileformat'},
	},
	extensions = {'nvim-tree', 'fzf'},
}
require("bufferline").setup{
	options = {
		show_close_icon = false,
		show_buffer_close_icons = false,
		indicator_icon = ' ',
		modified_icon = '',
		separator_style = {'',''},
		tab_size = 5,
		offsets = {
			{
					filetype = 'NvimTree',
					text = 'NvimTree',
			}
		},
	},
	highlights = {
		fill = {
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
		},
		background = {
			guibg = { attribute = 'bg', highlight = 'NvimTreeNormal' },
		},
		buffer_selected = {
			gui = 'none',
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		buffer_visible = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		indicator_selected = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
		modified_selected = {
			guibg = { attribute = 'bg', highlight = 'CursorLine' }
		},
	}
}
EOF

" nvim-tree
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

" fzf
let g:fzf_files_options = '--no-exact --tiebreak=end --prompt="> "'
let g:fzf_colors = {
	\ 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'NvimTreeNormal'],
	\ 'hl':      ['fg', 'Statement'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment']
	\ }

" indent-blankline
let g:indentLine_char = '▏'
let g:indent_blankline_filetype_exclude = ['man', 'help']

" vim-go
let g:go_echo_command_info = 0
