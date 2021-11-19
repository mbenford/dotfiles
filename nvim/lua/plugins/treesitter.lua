local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main"
	},
}

require'nvim-treesitter.configs'.setup{
	ensure_installed = {
		'go',
		'gomod',
		'python',
		'javascript',
		'json',
		'typescript',
		'tsx',
		'lua',
		'bash',
		'c',
		'cpp',
		'css',
		'scss',
		'dockerfile',
		'rust',
		'yaml',
		'toml',
		'norg',
	},
	highlight = { enable= true },
	indent = { enabled = true },
	incremental_selection = { enabled = true },
}

vim.wo.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
