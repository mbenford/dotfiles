local function load_packer()
	local plugins = {
		{ 'wbthomason/packer.nvim', opt = true },

		-- theme
		{ 'navarasu/onedark.nvim' },

		-- treesitter
		{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
		{ 'nvim-treesitter/playground', after = 'nvim-treesitter', cmd = 'TSPlayground' },

		-- fuzzy search
		{ 'nvim-telescope/telescope.nvim', after = 'onedark.nvim' },
		{ 'natecraddock/telescope-zf-native.nvim', after = 'telescope.nvim' },
		{ 'AckslD/nvim-neoclip.lua', after = 'telescope.nvim' },

		-- navigation
		{ 'ggandor/leap.nvim', event = 'BufRead' },
		{ 'ggandor/flit.nvim', after = 'leap.nvim' },
		{ 'chaoren/vim-wordmotion', event = 'BufRead' },
		{ 'andymass/vim-matchup', after = 'onedark.nvim' },

		-- completion
		{ 'hrsh7th/nvim-cmp', event = 'InsertEnter' },
		{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
		{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
		{ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },

		-- editing
		{ 'wellle/targets.vim', event = 'BufRead' },
		{ 'numToStr/Comment.nvim', event = 'BufRead' },
		{ 'kylechui/nvim-surround', event = 'BufRead' },
		{ 'mg979/vim-visual-multi', event = 'BufRead' },
		{ 'windwp/nvim-autopairs', after = 'nvim-cmp' },
		{ 'windwp/nvim-ts-autotag', event = 'BufRead' },
		{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', event = 'BufRead' },
		{ 'ThePrimeagen/refactoring.nvim' },
		{ 'abecodes/tabout.nvim', after = 'nvim-cmp', event = 'BufRead' },
		{ 'Wansmer/treesj', after = 'nvim-treesitter' },

		-- LSP
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim', after = 'mason.nvim' },
		{ 'neovim/nvim-lspconfig', after = 'mason-lspconfig.nvim' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'jose-elias-alvarez/null-ls.nvim', event = 'BufRead' },
		{ 'ray-x/lsp_signature.nvim', event = 'BufRead' },
		{ 'folke/trouble.nvim', event = 'BufRead' },
		{ 'j-hui/fidget.nvim', after = 'mason-lspconfig.nvim' },

		-- DAP
		{ 'mfussenegger/nvim-dap', module = 'dap' },
		{ 'rcarriga/nvim-dap-ui', after = 'nvim-dap' },
		{ 'nvim-telescope/telescope-dap.nvim', after = 'nvim-dap' },
		{ 'leoluz/nvim-dap-go', after = 'nvim-dap' },

		-- languages
		{ 'ray-x/go.nvim', ft = 'go' },
		{ 'folke/lua-dev.nvim', ft = 'lua' },
		{ 'chr4/nginx.vim', ft = 'nginx' },
		{ 'hashivim/vim-terraform' },
		{ 'fladson/vim-kitty' },

		-- snippets
		{ 'L3MON4D3/LuaSnip', after = 'nvim-cmp' },
		{ 'rafamadriz/friendly-snippets', after = 'LuaSnip' },

		-- Git
		{ 'lewis6991/gitsigns.nvim', after = 'onedark.nvim', event = 'BufRead' },
		{ 'akinsho/git-conflict.nvim', event = 'BufRead' },

		-- UI
		{ 'kyazdani42/nvim-web-devicons' },
		{ 'kyazdani42/nvim-tree.lua', after = 'onedark.nvim' },
		{ 'noib3/cokeline.nvim', after = 'onedark.nvim' },
		{ 'nvim-lualine/lualine.nvim', after = 'onedark.nvim' },
		{ 'lukas-reineke/indent-blankline.nvim', event = 'BufRead' },
		{ 'NvChad/nvim-colorizer.lua', event = 'BufRead' },
		{ 'kevinhwang91/nvim-bqf', after = 'onedark.nvim', event = 'BufRead' },
		{ 'romgrk/nvim-treesitter-context', after = 'onedark.nvim', event = 'BufRead' },
		{ 'folke/todo-comments.nvim', event = 'BufRead' },
		{ 'stevearc/dressing.nvim', after = 'onedark.nvim' },
		{ 'rcarriga/nvim-notify', after = 'onedark.nvim' },

		-- misc
		{ 'nvim-lua/plenary.nvim' },
		{ 'dstein64/vim-startuptime' },
		{ 'tpope/vim-eunuch' },
		{ 'tpope/vim-repeat' },
		{ 'nmac427/guess-indent.nvim', event = 'BufRead' },
		{ 'gpanders/editorconfig.nvim' },
		{ 'McAuleyPenney/tidy.nvim' },
		{ 'akinsho/toggleterm.nvim', keys = '<C-Enter>' },
		{ 'nvim-neorg/neorg', after = { 'nvim-treesitter', 'telescope.nvim' }, ft = 'norg' },
		{ 'famiu/bufdelete.nvim' },
		{ 'mbbill/undotree', event = 'BufRead' },
		{ 'mrjones2014/legendary.nvim' },
		{ 'antoinemadec/FixCursorHold.nvim' },
		{ 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' },
		{ 'rafcamlet/nvim-luapad', cmd = 'Luapad' },
		{ 'm-demare/hlargs.nvim', after = 'nvim-treesitter' },
		{ 'b0o/schemastore.nvim' },
	}

	local border = require('utils.ui').border_float
	local config = {
		display = {
			compact = true,
			prompt_border = border,
			open_fn = function()
				return require('packer.util').float({ border = border })
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
user_command('PackerUpdate', function()
	load_packer()
	require('packer').update({ preview_updates = true })
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
	'tarPlugin',
	'tutor_mode_plugin',
	'zipPlugin',
	'remote_plugins',
}
for _, name in ipairs(builtin_plugins) do
	vim.g['loaded_' .. name] = true
end
