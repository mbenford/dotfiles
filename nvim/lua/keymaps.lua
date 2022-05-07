local legendary = require('legendary')
local lazy = require('legendary.helpers').lazy
legendary.bind_keymaps({
	{ ';', ':', mode = { 'n', 'x' }, opts = { silent = false }, description = 'Command line mode' },
	{ 'H', '^', mode = { 'n', 'x', 'o' }, description = 'Go to first non-blank character of the line' },
	{ 'L', '$', mode = { 'n', 'x', 'o' }, description = 'Go to end of the line' },
	{ 'M', '%', mode = { 'n', 'x', 'o' }, description = 'Go to matching pair' },
	{ 'Q', '<cmd>execute "noautocmd normal! " . v:count1 . "@" . getcharstr()<cr>', description = 'Alias for @' },
	{ '<', '<gv', mode = { 'x' }, description = 'Shift left and keep selection' },
	{ '>', '>gv', mode = { 'x' }, description = 'Shift right and keep selection' },
	{ 'U', '<C-R>', description = 'Redo' },
	{ 'j', 'gj', description = 'Go down (non-linewise)' },
	{ 'k', 'gk', description = 'Go up (non-linewise)' },
	{ 'n', 'nzz', description = 'Go to next occurrence and center' },
	{ 'N', 'Nzz', description = 'Go to previous occurrence and center' },
	{ '*', '*zz', description = 'Search forward and center' },
	{ '#', '#zz', description = 'Search backward and center' },
	{ 'J', 'maJ`a', description = 'Join lines and keep the cursor at its position' },
	{ 'c', '"_c', mode = { 'n', 'x' }, description = 'Same as c but using the black hole register' },
	{ 'C', '"_C', mode = { 'n', 'x' }, description = 'Same as C but using the black hole register' },
	{ 'x', '"_x', mode = { 'n', 'x' }, description = 'Same as x but using the black hole register' },
	{ 'X', '"_dd', description = 'Delete the current line into the black hole register' },
	{ '<Leader>w', '<Cmd>wa<CR>', description = 'Write all changed buffers' },
	{ '<Leader>qx', '<Cmd>xa<CR>', description = 'Write all changed buffers and exit' },
	{ '<Leader>qq', '<Cmd>qa<CR>', description = 'Exit' },
	{ '<Leader>qw', '<C-w>q', description = 'Close window' },
	{ '<Leader>Q', '<Cmd>qa!<CR>', description = 'Exit without writing' },
	{ '<Leader>i', 'i<Space><Esc>r', description = 'Insert one character' },
	{ '<Leader>o', 'mao<Esc>`a', description = 'Insert empty line below' },
	{ '<Leader>O', 'maO<Esc>`a', description = 'Insert empty line above' },
	{ '<Leader>y', '"+yy', description = 'Yank current line to clipboard' },
	{ '<Leader>y', '"+y', mode = { 'x' }, description = 'Yank selected lines to clipboard' },
	{ '<Leader>p', '"+p', description = 'Paste from clipboard after the cursor' },
	{ '<Leader>P', '"+P', description = 'Paste from clipboard before the cursor' },
	{ '<M-h>', '<C-w>h', description = 'Go to left window' },
	{ '<M-j>', '<C-w>j', description = 'Go to bottom window' },
	{ '<M-k>', '<C-w>k', description = 'Go to top window' },
	{ '<M-l>', '<C-w>l', description = 'Go to right window' },
	{ '<M-h>', '<C-\\><C-n><C-w>h', mode = { 'i', 't' }, description = 'Go to left window' },
	{ '<M-j>', '<C-\\><C-n><C-w>j', mode = { 'i', 't' }, description = 'Go to bottom window' },
	{ '<M-k>', '<C-\\><C-n><C-w>k', mode = { 'i', 't' }, description = 'Go to top window' },
	{ '<M-l>', '<C-\\><C-n><C-w>l', mode = { 'i', 't' }, description = 'Go to right window' },
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
	{ '<Leader>sh', '<Cmd>split<CR>', description = 'Split window horizontally' },
	{ '<Leader>sv', '<Cmd>vsplit<CR>', description = 'Split window vertically' },
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
})

legendary.bind_autocmds({
	{
		'FileType',
		lazy(legendary.bind_keymaps, {
			{ 'q', '<C-w>q', opts = { buffer = true }, description = 'Close window' },
		}),
		opts = { pattern = 'help,qf' },
	},
})
