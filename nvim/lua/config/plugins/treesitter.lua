return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	event = { 'BufRead', 'BufWritePost' },
	dependencies = {
		'nvim-treesitter/playground',
	},
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				'bash',
				'c',
				'cmake',
				'cpp',
				'css',
				'dockerfile',
				'fennel',
				'git_rebase',
				'gitattributes',
				'gitcommit',
				'go',
				'gomod',
				'gosum',
				'gowork',
				'hcl',
				'html',
				'http',
				'javascript',
				'jsdoc',
				'json',
				'lua',
				'luap',
				'make',
				'markdown',
				'markdown_inline',
				'norg',
				'proto',
				'python',
				'query',
				'rasi',
				'regex',
				'rust',
				'scss',
				'terraform',
				'toml',
				'tsx',
				'typescript',
				'vim',
				'yaml',
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<Leader>vv',
					node_incremental = '<Leader>vv',
					node_decremental = '<Leader>vd',
					scope_incremental = '<Leader>vs',
				},
			},
			indent = { enable = false },
			playground = { enable = true },
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { 'BufWrite', 'CursorHold' },
			},
			autotag = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = false,
					keymaps = {
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ax'] = '@block.inner',
					},
					selection_modes = {
						['@function.outer'] = 'V',
						['@function.inner'] = 'V',
					},
				},
			},
			matchup = { enable = true },
		})

		local ts = vim.treesitter
		ts.language.register('pcss', 'scss')
	end,
}
