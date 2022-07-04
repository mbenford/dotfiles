local function load_packer()
	local plugins = {
		{ 'wbthomason/packer.nvim', opt = true },

		-- theme
		{ 'navarasu/onedark.nvim' },

		-- Treesitter
		{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
		{ 'nvim-treesitter/playground', after = 'nvim-treesitter', cmd = 'TSPlayground' },

		-- fuzzy search
		{ 'nvim-telescope/telescope.nvim', after = 'onedark.nvim' },
		{ 'natecraddock/telescope-zf-native.nvim', after = 'telescope.nvim' },
		{ 'AckslD/nvim-neoclip.lua', after = 'telescope.nvim' },

		-- navigation
		{ 'phaazon/hop.nvim', after = 'onedark.nvim', event = 'BufRead' },
		{ 'chaoren/vim-wordmotion', event = 'BufRead' },

		-- completion
		{ 'hrsh7th/nvim-cmp', event = 'InsertEnter' },
		{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
		{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
		{ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },

		-- editing
		{ 'wellle/targets.vim', event = 'BufRead' },
		{ 'numToStr/Comment.nvim', event = 'BufRead' },
		{ 'tpope/vim-surround', event = 'BufRead' },
		{ 'mg979/vim-visual-multi', event = 'BufRead' },
		{ 'windwp/nvim-autopairs', after = 'nvim-cmp' },
		{ 'windwp/nvim-ts-autotag', event = 'BufRead' },
		{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', event = 'BufRead' },
		{ 'ThePrimeagen/refactoring.nvim' },
		{ 'abecodes/tabout.nvim', after = 'nvim-cmp', event = 'BufRead' },

		-- LSP
		{ 'williamboman/nvim-lsp-installer' },
		{ 'neovim/nvim-lspconfig', after = 'nvim-lsp-installer' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'jose-elias-alvarez/null-ls.nvim', event = 'BufRead' },
		{ 'ray-x/lsp_signature.nvim', event = 'BufRead' },
		{ 'folke/trouble.nvim', event = 'BufRead' },

		-- debugging
		-- { 'mfussenegger/nvim-dap' },
		-- { 'Pocco81/DAPInstall.nvim' },

		-- snippets
		{ 'L3MON4D3/LuaSnip', after = 'nvim-cmp' },
		{ 'rafamadriz/friendly-snippets', after = 'LuaSnip' },

		-- UI
		{ 'kyazdani42/nvim-web-devicons' },
		{ 'kyazdani42/nvim-tree.lua', after = 'onedark.nvim' },
		{ 'noib3/cokeline.nvim', after = 'onedark.nvim' },
		{ 'nvim-lualine/lualine.nvim', after = 'onedark.nvim' },
		{ 'lukas-reineke/indent-blankline.nvim', event = 'BufRead' },
		{ 'lewis6991/gitsigns.nvim', after = 'onedark.nvim', event = 'BufRead' },
		{ 'norcalli/nvim-colorizer.lua', event = 'BufRead' },
		{ 'kevinhwang91/nvim-bqf', event = 'BufRead' },
		{ 'romgrk/nvim-treesitter-context', after = 'onedark.nvim', event = 'BufRead' },
		{ 'folke/todo-comments.nvim', event = 'BufRead' },
		{ 'stevearc/dressing.nvim', after = 'onedark.nvim' },
		{ 'rcarriga/nvim-notify', after = 'onedark.nvim' },

		-- file types
		{ 'folke/lua-dev.nvim', ft = 'lua' },
		{ 'chr4/nginx.vim', ft = 'nginx' },
		{ 'hashivim/vim-terraform' },
		{ 'fladson/vim-kitty' },

		-- misc
		{ 'nvim-lua/plenary.nvim' },
		{ 'dstein64/vim-startuptime' },
		{ 'tpope/vim-eunuch' },
		{ 'tpope/vim-repeat' },
		{ 'editorconfig/editorconfig-vim', event = 'BufRead' },
		{ 'McAuleyPenney/tidy.nvim' },
		{ 'kazhala/close-buffers.nvim' },
		{ 'akinsho/toggleterm.nvim', keys = '<leader><cr>' },
		{ 'lewis6991/spellsitter.nvim', event = 'BufRead' },
		{ 'nvim-neorg/neorg', ft = 'norg' },
		{ 'mbbill/undotree', event = 'BufRead' },
		{ 'mrjones2014/legendary.nvim' },
	}

	local config = {
		display = {
			open_fn = function()
				return require('packer.util').float({ border = require('utils.ui').border_float })
			end,
		},
	}

	vim.cmd('packadd packer.nvim')
	local packer = require('packer')
	local startup = require('utils.autoconfig')(packer.startup)
	return startup({ plugins, config = config })
end

local user_command = vim.api.nvim_create_user_command
user_command('PackerCompile', function(opts)
	load_packer()
	require('packer').compile(opts.args)
end, { nargs = '*' })
user_command('PackerSync', function()
	load_packer()
	require('packer').sync()
end, {})
user_command('PackerStatus', function()
	load_packer()
	require('packer').status()
end, {})
user_command('PackerClean', function()
	load_packer()
	require('packer').clean()
end, {})
user_command('PackerProfile', function()
	load_packer()
	require('packer').profile_output()
end, {})

vim.api.nvim_create_autocmd('BufWritePost', { pattern = 'plugins.lua', command = 'source <afile>' })

-- Disable builtin plugins
local builtin_plugins = {
	'2html_plugin',
	'gzip',
	'netrwPlugin',
	'tarPlugin',
	'tutor_mode_plugin',
	'zipPlugin',
	'remote_plugins',
}
for _, name in ipairs(builtin_plugins) do
	vim.g['loaded_' .. name] = true
end
