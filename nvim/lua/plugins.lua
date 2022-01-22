function _G.__load_packer()
	vim.cmd('packadd packer.nvim')

	local packer = require('packer')
	local startup = require('utils.autoconfig')(packer.startup)
	return startup({
		{
			{ 'wbthomason/packer.nvim', opt = true },
			{ 'nvim-lua/plenary.nvim' },

			-- theme
			{ 'navarasu/onedark.nvim' },

			-- Treesitter
			{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
			{ 'nvim-treesitter/playground', after = 'nvim-treesitter', cmd = 'TSPlayground' },

			-- fuzzy search
			{ 'nvim-telescope/telescope.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

			-- navigation
			{ 'phaazon/hop.nvim', after = 'onedark.nvim', event = 'BufRead' },
			{ 'chaoren/vim-wordmotion', event = 'BufRead' },

			-- completion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },

			-- editing
			{ 'wellle/targets.vim', event = 'BufRead' },
			{ 'numToStr/Comment.nvim', event = 'BufRead' },
			{ 'tpope/vim-surround', event = 'BufRead' },
			{ 'mg979/vim-visual-multi', event = 'BufRead' },
			{ 'windwp/nvim-autopairs', event = 'BufRead' },
			{ 'windwp/nvim-ts-autotag', event = 'BufRead' },
			{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter', event = 'BufRead' },

			-- LSP
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/nvim-lsp-installer', after = 'nvim-cmp' },
			{ 'jose-elias-alvarez/null-ls.nvim', event = 'BufRead' },
			{ 'ray-x/lsp_signature.nvim', event = 'BufRead' },
			{ 'kosayoda/nvim-lightbulb', event = 'BufRead' },
			{ 'folke/trouble.nvim', event = 'BufRead' },

			-- debugging
			{ 'mfussenegger/nvim-dap' },
			{ 'Pocco81/DAPInstall.nvim' },

			-- snippets
			{ 'hrsh7th/vim-vsnip', after = 'nvim-cmp' },
			{ 'rafamadriz/friendly-snippets', after = 'nvim-cmp' },

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
			{ 'stevearc/dressing.nvim' },

			-- file types
			{ 'hashivim/vim-terraform', ft = 'terraform' },
			{ 'folke/lua-dev.nvim', ft = 'lua' },
			{ 'chr4/nginx.vim', ft = 'nginx' },

			-- misc
			{ 'dstein64/vim-startuptime' },
			{ 'tpope/vim-eunuch' },
			{ 'editorconfig/editorconfig-vim', event = 'BufRead' },
			{ 'McAuleyPenney/tidy.nvim' },
			{ 'kazhala/close-buffers.nvim' },
			{ 'akinsho/toggleterm.nvim', keys = '<leader><cr>' },
			{ 'AckslD/nvim-neoclip.lua', after = 'telescope.nvim' },
			{ 'sudormrfbin/cheatsheet.nvim', after = 'telescope.nvim', keys = '<leader>?' },
			{ 'lewis6991/spellsitter.nvim', event = 'BufRead' },
		},
		config = {
			display = {
				open_fn = function()
					return require('packer.util').float({ border = 'single' })
				end,
			},
		},
	})
end

vim.cmd([[
	command! -nargs=* PackerCompile lua _G.__load_packer();require'packer'.compile(<q-args>)
	command! -nargs=0 PackerSync lua _G.__load_packer();require'packer'.sync()
	command! -nargs=0 PackerStatus lua _G.__load_packer();require'packer'.status()
	command! -nargs=0 PackerClean lua _G.__load_packer();require'packer'.clean()
	command! -nargs=0 PackerProfile lua _G.__load_packer();require'packer'.profile_output()
]])
