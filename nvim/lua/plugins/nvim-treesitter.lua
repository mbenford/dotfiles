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
		'make',
		'markdown',
		'norg',
		'python',
		'query',
		'rasi',
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
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ax'] = '@block.inner',
			},
		},
	},
})

vim.wo.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
