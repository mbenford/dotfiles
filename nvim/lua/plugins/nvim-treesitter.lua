require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'bash',
		'c',
		'cpp',
		'css',
		'dockerfile',
		'go',
		'gomod',
		'gowork',
		'html',
		'http',
		'javascript',
		'jsdoc',
		'json',
		'lua',
		'markdown',
		'make',
		'python',
		'query',
		'rust',
		'scss',
		'toml',
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
			init_selection = 'gnn',
			node_incremental = 'grn',
			scope_incremental = 'grc',
			node_decremental = 'grm',
		},
	},
	indent = { enable = true },
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
			},
		},
	},
})

vim.wo.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
