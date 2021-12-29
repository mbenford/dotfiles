vim.cmd'packadd packer.nvim'

local packer = require'packer'
local startup = require'autoconfig'(packer.startup)
return startup({{
	{'wbthomason/packer.nvim', opt = true},

	-- Treesitter
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},

	-- LSP
	{'neovim/nvim-lspconfig'},
	{'williamboman/nvim-lsp-installer'},
	{'ray-x/lsp_signature.nvim'},
	{'onsails/lspkind-nvim'},
	{'jose-elias-alvarez/null-ls.nvim'},
	{'kosayoda/nvim-lightbulb'},

	-- completion
	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-nvim-lua'},
	{'hrsh7th/cmp-vsnip'},

	-- snippets
	{'hrsh7th/vim-vsnip'},
	{'rafamadriz/friendly-snippets'},

	-- theme
	{'navarasu/onedark.nvim'},

	-- fuzzy search
	{'nvim-telescope/telescope.nvim'},
	{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

	-- UI
	{'kyazdani42/nvim-web-devicons'},
	{'kyazdani42/nvim-tree.lua', after = 'onedark.nvim'},
	{'noib3/cokeline.nvim', after = 'onedark.nvim'},
	{'nvim-lualine/lualine.nvim', after = 'onedark.nvim'},
	{'lukas-reineke/indent-blankline.nvim'},
	{'lewis6991/gitsigns.nvim', after = 'onedark.nvim'},
	{'norcalli/nvim-colorizer.lua'},
	{'kevinhwang91/nvim-bqf'},
	{'romgrk/nvim-treesitter-context', after = 'onedark.nvim'},
	{'folke/todo-comments.nvim'},
	{'folke/trouble.nvim'},

	-- languages
	{'hashivim/vim-terraform', ft = 'terraform'},
	{'folke/lua-dev.nvim', ft = 'lua'},
	{'chr4/nginx.vim', ft = 'nginx'},

	-- editing
	{'wellle/targets.vim'},
	{'numToStr/Comment.nvim'},
	{'tpope/vim-surround'},
	{'mg979/vim-visual-multi'},
	{'windwp/nvim-autopairs'},

	-- navigation
	{'phaazon/hop.nvim', after = 'onedark.nvim'},
	{'chaoren/vim-wordmotion'},

	-- misc
	{'nvim-lua/plenary.nvim'},
	{'dstein64/vim-startuptime'},
	{'tpope/vim-eunuch'},
	{'editorconfig/editorconfig-vim'},
	{'McAuleyPenney/tidy.nvim'},
	{'famiu/bufdelete.nvim'},
	{"akinsho/toggleterm.nvim"},

	},

	-- packer config
	config = {
		display = {
			open_fn = function()
				return require'packer.util'.float({border = 'none'})
			end,
		},
	},
})
