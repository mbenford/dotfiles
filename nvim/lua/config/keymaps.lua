local legendary = require('legendary')
local lazy = require('legendary.toolbox').lazy
legendary.keymaps({
	{
		';',
		':',
		mode = { 'n', 'x' },
		opts = {
			silent = false,
		},
		description = 'Command line mode',
	},
	{
		'H',
		'^',
		mode = { 'n', 'x', 'o' },
		opts = {
			remap = true,
		},
		description = 'Alias for ^',
	},
	{
		'L',
		'g_',
		mode = { 'n', 'x', 'o' },
		opts = {
			remap = true,
		},
		description = 'Alias for g_',
	},
	{
		'M',
		'%',
		mode = { 'n', 'x', 'o' },
		opts = {
			remap = true,
		},
		description = 'Alias for %',
	},
	{ 'Q', '<cmd>execute "noautocmd normal! " . v:count1 . "@" . getcharstr()<cr>', description = 'Alias for @' },
	{
		'<',
		'<gv',
		mode = { 'x' },
		description = 'Shift left and keep selection',
	},
	{
		'>',
		'>gv',
		mode = { 'x' },
		description = 'Shift right and keep selection',
	},
	{ 'U', '<C-R>', description = 'Redo' },
	{
		'j',
		'gj',
		description = 'Go down (non-linewise)',
	},
	{
		'k',
		'gk',
		description = 'Go up (non-linewise)',
	},
	{
		'n',
		'nzz',
		description = 'Go to next occurrence and center',
	},
	{
		'N',
		'Nzz',
		description = 'Go to previous occurrence and center',
	},
	{
		'<C-d>',
		'<C-d>zz',
		description = 'Scroll down and center',
	},
	{
		'<C-u>',
		'<C-u>zz',
		description = 'Scroll up and center',
	},
	{
		'*',
		'*zz',
		description = 'Search forward and center',
	},
	{
		'#',
		'#zz',
		description = 'Search backward and center',
	},
	{
		'J',
		'maJ`a',
		description = 'Join lines and keep the cursor at its position',
	},
	{ 'x', '"_x', mode = { 'n', 'x' }, description = 'Same as x but uses the black hole register' },
	{ 'X', '"_dd', description = 'Delete the current line into the black hole register' },
	{
		'<Tab>',
		'<C-^>',
		description = 'Switch to the alternate buffer',
	},
	{
		'dd',
		function()
			return vim.api.nvim_get_current_line():match('^%s*$') and '"_dd' or 'dd'
		end,
		mode = { 'n' },
		opts = { expr = true },
		description = 'Same as dd but uses the black hole register for empty lines',
	},
	{ '<Leader>w', '<Cmd>silent! wa<CR>', description = 'Write all changed buffers' },
	{ '<Leader>qx', '<Cmd>xa<CR>', description = 'Write all changed buffers and exit' },
	{ '<Leader>qq', '<Cmd>qa<CR>', description = 'Exit' },
	{ '<Leader>qw', '<Cmd>q<CR>', description = 'Close current window' },
	{ '<Leader>Q', '<Cmd>qa!<CR>', description = 'Exit without writing' },
	{ '<Leader>i', 'i<Space><Esc>r', description = 'Insert one character' },
	{ '<Leader>o', 'mao<Esc>`a', description = 'Insert empty line below' },
	{ '<Leader>O', 'maO<Esc>`a', description = 'Insert empty line above' },
	{ '<Leader>y', '"+yy', description = 'Yank current line to clipboard' },
	{
		'<Leader>y',
		'"+y',
		mode = { 'x' },
		description = 'Yank selected lines to clipboard',
	},
	{ '<Leader>p', '"+p', description = 'Paste from clipboard after the cursor' },
	{ '<Leader>P', '"+P', description = 'Paste from clipboard before the cursor' },
	{ '<C-Down>', '<Cmd>move +1<CR>==', description = 'Move the current line down' },
	{ '<C-Up>', '<Cmd>move -2<CR>==', description = 'Move the current line up' },
	{
		'<C-Down>',
		":m '>+1<CR>gv=gv",
		mode = { 'v' },
		description = 'Move selected lines line down',
	},
	{
		'<C-Up>',
		":m '<-2<CR>gv=gv",
		mode = { 'v' },
		description = 'Move selected lines line up',
	},
	-- These shortcuts are handled by smart-splits.nvim
	-- { '<C-h>', '<C-w>h', description = 'Go to left window' },
	-- { '<C-j>', '<C-w>j', description = 'Go to bottom window' },
	-- { '<C-k>', '<C-w>k', description = 'Go to top window' },
	-- { '<C-l>', '<C-w>l', description = 'Go to right window' },
	{ '<C-Esc>', '<C-\\><C-n>', mode = { 't' }, description = '' },
	{
		'<C-h>',
		'<C-\\><C-n><C-w>h',
		mode = { 'i', 't' },
		description = 'Go to left window',
	},
	{
		'<C-j>',
		'<C-\\><C-n><C-w>j',
		mode = { 'i', 't' },
		description = 'Go to bottom window',
	},
	{
		'<C-k>',
		'<C-\\><C-n><C-w>k',
		mode = { 'i', 't' },
		description = 'Go to top window',
	},
	{
		'<C-l>',
		'<C-\\><C-n><C-w>l',
		mode = { 'i', 't' },
		description = 'Go to right window',
	},
	{
		'gx',
		function()
			vim.loop.spawn('xdg-open', { args = { vim.fn.expand('<cfile>') }, detached = true })
		end,
		description = 'Open the URL under the cursor',
	},
	{ '<Leader>d', '<Cmd>copy .<CR>', description = 'Duplicate current line' },
	{ '<Leader>d', ":copy '><CR>", mode = { 'x' }, description = 'Duplicate selected lines' },
	{
		'<Leader>tn',
		'<Cmd>set number! | set relativenumber!<CR>',
		description = 'Toggle relative numbers',
	},
	{ '<Leader>tw', '<Cmd>set wrap!<CR>', description = 'Toggle line wrap' },
	{ '<Leader>th', '<Cmd>set hlsearch!<CR>', description = 'Toggle search highlight' },
	{ '<Leader>ts', '<Cmd>set spell!<CR>', description = 'Toggle spell checking' },
	{ '<Leader>sh', '<Cmd>aboveleft vsplit<CR>', description = 'Split window horizontally' },
	{ '<Leader>sj', '<Cmd>belowright split<CR>', description = 'Split window horizontally' },
	{ '<Leader>sk', '<Cmd>aboveleft split<CR>', description = 'Split window horizontally' },
	{ '<Leader>sl', '<Cmd>belowright vsplit<CR>', description = 'Split window vertically' },
	{ '<M-H>', '<Cmd>vertical resize -2<CR>', description = 'Resize window left' },
	{ '<M-J>', '<Cmd>resize -2<CR>', description = 'Resize window down' },
	{ '<M-K>', '<Cmd>resize +2<CR>', description = 'Resize window up' },
	{ '<M-L>', '<Cmd>vertical resize +2<CR>', description = 'Resize window right' },
	{
		'<Up>',
		function()
			return vim.fn.pumvisible() == 1 and '<Left>' or '<Up>'
		end,
		mode = { 'c' },
		opts = { expr = true, silent = false },
		description = 'Up when PMenu is visible',
	},
	{
		'<Down>',
		function()
			return vim.fn.pumvisible() == 1 and '<Right>' or '<Down>'
		end,
		mode = { 'c' },
		opts = { expr = true, silent = false },
		description = 'Down when PMenu is visible',
	},
	{ '<Leader>k', vim.diagnostic.open_float, description = 'Open diagnostic window for current line' },
	{ '[d', vim.diagnostic.goto_prev, description = 'Go to previous diagnostic' },
	{ ']d', vim.diagnostic.goto_next, description = 'Go to next diagnostic' },
	{
		'[e',
		lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR }),
		description = 'Go to previous diagnostic error',
	},
	{
		']e',
		lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR }),
		description = 'Go to next diagnostic error',
	},
	{ '[q', '<Cmd>cp<CR>', description = 'Go to previous item on quickfix list' },
	{ ']q', '<Cmd>cn<CR>', description = 'Go to next item on quickfix list' },
})

legendary.autocmds({
	{
		'FileType',
		lazy(legendary.keymaps, {
			{ 'q', '<C-w>q', opts = { buffer = true }, description = 'Close window' },
		}),
		opts = { pattern = 'help,qf' },
	},
})
