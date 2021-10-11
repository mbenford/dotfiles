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
	use 'kabouzeid/nvim-lspinstall'
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

	-- UI
	use {'kyazdani42/nvim-web-devicons', config_file = 'plugins/web-devicons'}
	use {'kyazdani42/nvim-tree.lua', after = 'onedark.nvim', config_file = 'plugins/nvim-tree'}
	-- use {'akinsho/bufferline.nvim', after = 'onedark.nvim', config_file = 'plugins/bufferline'}
	use {'noib3/cokeline.nvim', after = 'onedark.nvim', config_file = 'plugins/cokeline'}
	use {'shadmansaleh/lualine.nvim', after = 'onedark.nvim', config_file = 'plugins/lualine'}
	use {'lukas-reineke/indent-blankline.nvim', config_file = 'plugins/indent-blankline'}
	use {'lewis6991/gitsigns.nvim', after = 'onedark.nvim', config_file = 'plugins/gitsigns'}
	use {'norcalli/nvim-colorizer.lua', config_file = 'plugins/colorizer'}
	use 'famiu/bufdelete.nvim'
	use 'kevinhwang91/nvim-bqf'
	use {'romgrk/nvim-treesitter-context', config_file = 'plugins/treesitter-context'}
	use {'folke/todo-comments.nvim', config_file = 'plugins/todo-comments'}

	-- languages
	use {'hashivim/vim-terraform', opt = true, ft = 'tf'}

	-- editing
	use 'wellle/targets.vim'
	use {'b3nj5m1n/kommentary', config_file = 'plugins/kommentary'}
	use 'tpope/vim-surround'
	use 'mg979/vim-visual-multi'
	use {'windwp/nvim-autopairs', config_file = 'plugins/autopairs'}

	-- navigation
	use {'ggandor/lightspeed.nvim', config_file = 'plugins/lightspeed'}
	use 'chaoren/vim-wordmotion'

	-- misc
	use 'nvim-lua/plenary.nvim'
	use 'dstein64/vim-startuptime'
	use 'tpope/vim-eunuch'
	use 'terryma/vim-expand-region'
	use {'nvim-neorg/neorg', opt = true, ft = 'norg', config_file = 'plugins/neorg'}
	use 'editorconfig/editorconfig-vim'
	use {'ntpeters/vim-better-whitespace', config_file = 'plugins/better-whitespace'}
end)

packer.set_handler('config_file', function(plugins, plugin, value)
	if value and plugin.config == nil then
		plugin.config = string.format('require"%s"', value)
	end
end)
