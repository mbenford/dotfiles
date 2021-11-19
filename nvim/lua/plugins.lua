vim.cmd 'packadd packer.nvim'

local packer = require'packer'
packer.startup(function(use)
	use {'wbthomason/packer.nvim', opt = true}

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config_file = 'plugins/treesitter'
	}

	-- IDE-like features
	use {'neovim/nvim-lspconfig', config_file = 'plugins/lsp'}
	use {'williamboman/nvim-lsp-installer', config_file = 'plugins/lsp-installer'}
	use {'hrsh7th/nvim-cmp', config_file = 'plugins/nvim-cmp'}
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-vsnip'
	use {'hrsh7th/vim-vsnip', config_file = 'plugins/vim-vsnip'}
	use 'rafamadriz/friendly-snippets'
	use {'ray-x/lsp_signature.nvim', config_file = 'plugins/lsp-signature'}
	use 'folke/trouble.nvim'

	-- theme
	use {'navarasu/onedark.nvim', config_file = 'plugins/onedark'}

	-- fuzzy search
	use {'nvim-telescope/telescope.nvim', config_file = 'plugins/telescope'}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	-- UI
	use {'kyazdani42/nvim-web-devicons', config_file = 'plugins/web-devicons'}
	use {'kyazdani42/nvim-tree.lua', commit = 'f92b7e7627c5a36f4af6814c408211539882c4f3', after = 'onedark.nvim', config_file = 'plugins/nvim-tree'}
	use {'noib3/cokeline.nvim', after = 'onedark.nvim', config_file = 'plugins/cokeline'}
	use {'nvim-lualine/lualine.nvim', after = 'onedark.nvim', config_file = 'plugins/lualine'}
	use {'lukas-reineke/indent-blankline.nvim', config_file = 'plugins/indent-blankline'}
	use {'lewis6991/gitsigns.nvim', after = 'onedark.nvim', config_file = 'plugins/gitsigns'}
	use {'norcalli/nvim-colorizer.lua', config_file = 'plugins/colorizer'}
	use 'famiu/bufdelete.nvim'
	use 'kevinhwang91/nvim-bqf'
	use {'romgrk/nvim-treesitter-context', after = 'onedark.nvim', config_file = 'plugins/treesitter-context'}
	use {'folke/todo-comments.nvim', config_file = 'plugins/todo-comments'}

	-- languages
	use {'hashivim/vim-terraform', ft = 'terraform'}
	use {'folke/lua-dev.nvim', ft = 'lua'}
	use {'chr4/nginx.vim', ft = 'nginx'}

	-- editing
	use 'wellle/targets.vim'
	use {'numToStr/Comment.nvim', config_file = 'plugins/comment'}
	use 'tpope/vim-surround'
	use 'mg979/vim-visual-multi'
	use {'windwp/nvim-autopairs', config_file = 'plugins/autopairs'}

	-- navigation
	use {'phaazon/hop.nvim', config_file = 'plugins/hop'}
	use 'chaoren/vim-wordmotion'

	-- misc
	use 'nvim-lua/plenary.nvim'
	use 'dstein64/vim-startuptime'
	use 'tpope/vim-eunuch'
	use 'terryma/vim-expand-region'
	use 'editorconfig/editorconfig-vim'
	use {'ntpeters/vim-better-whitespace', config_file = 'plugins/better-whitespace'}
	use 'mtth/scratch.vim'
	use {'nvim-neorg/neorg', ft = 'norg', config_file = 'plugins/neorg'}
end)

packer.set_handler('config_file', function(plugins, plugin, value)
	if value and plugin.config == nil then
		plugin.config = string.format('require"%s"', value)
	end
end)
