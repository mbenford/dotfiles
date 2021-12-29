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
	},
	highlight = { enable= true },
	indent = { enabled = true },
	incremental_selection = { enabled = false },
}

vim.wo.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
