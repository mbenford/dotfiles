vim.cmd 'packadd packer.nvim'

local packer = require'packer'
packer.startup(function(use)
	use {'wbthomason/packer.nvim', opt = true}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config_mod = 'plugins/treesitter'
	}

	-- IDE-like features
	use {'neovim/nvim-lspconfig', config_mod = 'plugins/lsp'}
	use 'kabouzeid/nvim-lspinstall'
	use {'hrsh7th/nvim-cmp', config_mod = 'plugins/nvim-cmp'}
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/vim-vsnip'
	use 'folke/trouble.nvim'

	-- theme
	use 'navarasu/onedark.nvim'

	-- fuzzy search
	use 'junegunn/fzf'
	use {'junegunn/fzf.vim', config_mod = 'plugins/fzf'}

	-- UI
	use 'kyazdani42/nvim-web-devicons'
	use {'kyazdani42/nvim-tree.lua', config_mod = 'plugins/nvim-tree'}
	use {'hoob3rt/lualine.nvim', config_mod = 'plugins/lualine'}
	use {'akinsho/nvim-bufferline.lua', config_mod = 'plugins/bufferline'}
	use 'ntpeters/vim-better-whitespace'
	use 'lukas-reineke/indent-blankline.nvim'
	use {'lewis6991/gitsigns.nvim', config_mod = 'plugins/gitsigns'}

	-- languages
	use {'fatih/vim-go', ft = 'go'}
	use {'hashivim/vim-terraform', ft = 'tf'}

	-- editing
	use 'preservim/nerdcommenter'
	use 'tpope/vim-surround'
	use 'mg979/vim-visual-multi'

	-- navigation
	use {'easymotion/vim-easymotion', config_mod='plugins/easymotion'}
	use 'chaoren/vim-wordmotion'

	-- misc
	use 'nvim-lua/plenary.nvim'
	use 'dstein64/vim-startuptime'
	use 'tpope/vim-eunuch'
	use 'wellle/targets.vim'
	use 'terryma/vim-expand-region'
	use 'nvim-neorg/neorg'
end)

packer.set_handler('config_mod', function(plugins, plugin, value)
	if value and plugin.config == nil then
		plugin.config = string.format('require"%s"', value)
	end
end)
