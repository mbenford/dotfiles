local legendary = require("legendary")
local lazy = require("legendary.toolbox").lazy
local apply_zz = require("utils.misc").apply_zz
local kitty = require("utils.kitty")

legendary.keymaps({
	{ "<Space>", "<Nop>", mode = { "n", "x" } },
	{ ";", ":", mode = { "n", "x" }, opts = { silent = false }, description = "Command line mode" },
	{ "H", "^", mode = { "n", "x", "o" }, opts = { remap = true }, description = "Alias for ^" },
	{ "L", "g_", mode = { "n", "x", "o" }, opts = { remap = true }, description = "Alias for g_" },
	{ "M", "%", mode = { "n", "x", "o" }, opts = { remap = true }, description = "Alias for %" },
	{ "Q", '<Cmd>execute "noautocmd normal! " . v:count1 . "@" . getcharstr()<cr>', description = "Alias for @" },
	{ "<", "<gv", mode = { "x" }, description = "Shift left and keep selection" },
	{ ">", ">gv", mode = { "x" }, description = "Shift right and keep selection" },
	{ "U", "<C-r>", description = "Redo" },
	{ "j", "gj", description = "Go down (non-linewise)" },
	{ "k", "gk", description = "Go up (non-linewise)" },
	{ "n", "nzz", description = "Go to next occurrence and center" },
	{ "N", "Nzz", description = "Go to previous occurrence and center" },
	{ "gg", "ggzz", description = "Go to line (default first line) and center" },
	{ "G", "Gzz", description = "Go to line (default last line) and center" },
	{ "<C-d>", "<C-d>zz", description = "Scroll down and center" },
	{ "<C-u>", "<C-u>zz", description = "Scroll up and center" },
	{ "*", "*zz", description = "Search forward and center" },
	{ "#", "#zz", description = "Search backward and center" },
	{ "J", "maJ`a", description = "Join lines and keep the cursor at its position" },
	{ "x", '"_x', mode = { "n", "x" }, description = "Same as x but uses the black hole register" },
	{ "X", '"_dd', description = "Delete the current line into the black hole register" },
	{ "<Tab>", "<C-^>zz", description = "Switch to the alternate buffer" },
	{ "<C-p>", "<Cmd>put<CR>", description = 'Put the text from register " on the line below' },
	{ "<C-S-p>", "<Cmd>put!<CR>", description = 'Put the text from register " on the line above' },
	{ "<C-q>", "<Cmd>qa<CR>", description = "Exit" },
	{ "<C-S-q>", "<Cmd>qa!<CR>", description = "Exit without saving" },
	{
		"dd",
		function()
			return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
		end,
		opts = { expr = true },
		description = "Same as dd but uses the black hole register for empty lines",
	},
	{ "<Leader>w", "<Cmd>silent! wa<CR>", description = "Write all changed buffers" },
	{ "<Leader>i", "i<Space><Esc>r", description = "Insert one character" },
	{ "<Leader>o", "mao<Esc>`a", description = "Insert empty line below" },
	{ "<Leader>O", "maO<Esc>`a", description = "Insert empty line above" },
	{ "<Leader>y", '"+yy', description = "Yank current line to clipboard" },
	{ "<Leader>y", '"+y', mode = { "x" }, description = "Yank selected lines to clipboard" },
	{ "<Leader>p", '"+p', description = "Paste from clipboard after the cursor" },
	{ "<Leader>P", '"+P', description = "Paste from clipboard before the cursor" },
	{ "cn", "*``micgn", description = "Change the word at the cursor and search next occurrences" },
	{ "cs", "*``:%s/<C-r><C-w>//g<Left><Left>", description = "Substitute all occurrences of the word at the cursor" },
	{ "<C-Down>", "<Cmd>move +1<CR>==", description = "Move the current line down" },
	{ "<C-Up>", "<Cmd>move -2<CR>==", description = "Move the current line up" },
	{ "<C-Down>", ":m '>+1<CR>gv=gv", mode = { "v" }, description = "Move selected lines line down" },
	{ "<C-Up>", ":m '<-2<CR>gv=gv", mode = { "v" }, description = "Move selected lines line up" },
	{
		"gco",
		function()
			if vim.o.commentstring == "" then
				return
			end

			local comment = string.gsub(vim.o.commentstring, "%%s", "")
			vim.cmd.normal("O")
			vim.cmd.normal("cc" .. comment)
			vim.cmd.startinsert({ bang = true })
		end,
	},
	{
		"gca",
		function()
			if vim.o.commentstring == "" then
				return
			end

			local comment = string.gsub(vim.o.commentstring, "%%s", "")
			vim.cmd.normal("A " .. comment)
			vim.cmd.startinsert({ bang = true })
		end,
	},
	{ "gct", "gcoTODO: ", opts = { remap = true }, description = "Add a TODO comment" },
	{ "gcn", "gcoNOTE: ", opts = { remap = true }, description = "Add a NOTE comment" },
	{ "gcf", "gcoFIXME: ", opts = { remap = true }, description = "Add a FIXME comment" },
	{ "<C-w><S-n>", "<Cmd>vnew<CR>", description = "Resize window left" },
	{ "<C-w><Tab>", "<C-w>^", description = "Resize window left" },
	{
		"<Up>",
		function()
			return vim.fn.pumvisible() == 1 and "<Left>" or "<Up>"
		end,
		mode = { "c" },
		opts = { expr = true, silent = false },
		description = "Up when PMenu is visible",
	},
	{
		"<Down>",
		function()
			return vim.fn.pumvisible() == 1 and "<Right>" or "<Down>"
		end,
		mode = { "c" },
		opts = { expr = true, silent = false },
		description = "Down when PMenu is visible",
	},
	{ "<Leader>k", vim.diagnostic.open_float, description = "Open diagnostic window for current line" },
	{ "[d", apply_zz(vim.diagnostic.goto_prev), description = "Go to previous diagnostic" },
	{ "]d", apply_zz(vim.diagnostic.goto_next), description = "Go to next diagnostic" },
	{
		"[e",
		apply_zz(lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR })),
		description = "Go to previous diagnostic error",
	},
	{
		"]e",
		apply_zz(lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR })),
		description = "Go to next diagnostic error",
	},
	{ "<Leader>q", "<Cmd>botright copen<CR>", description = "Open Quickfix window" },
	{ "[q", "<Cmd>cprev<CR>zz", description = "Go to previous item on quickfix list" },
	{ "]q", "<Cmd>cnext<CR>zz", description = "Go to next item on quickfix list" },
	{ "[l", "<Cmd>lprev<CR>zz", description = "Go to previous item on location list" },
	{ "]l", "<Cmd>lnext<CR>zz", description = "Go to next item on location list" },
	{ "<Esc>", "<Cmd>nohlsearch<CR><Esc>", mode = { "n" }, description = "Clear search highlight" },

	-- Toggles
	{ "<LocalLeader>tn", "<Cmd>set number!<CR>", description = "Toggle numbers" },
	{ "<LocalLeader>tr", "<Cmd>set relativenumber!<CR>", description = "Toggle relative numbers" },
	{ "<LocalLeader>tw", "<Cmd>set wrap!<CR>", description = "Toggle line wrap" },
	{ "<LocalLeader>th", "<Cmd>set hlsearch!<CR>", description = "Toggle search highlight" },
	{ "<LocalLeader>ts", "<Cmd>set spell!<CR>", description = "Toggle spell checking" },

	-- Git
	{
		"<Leader>gd",
		function()
			kitty.launch({ cmd = "git diff " .. vim.fn.expand("%"), title = "Git Diff" })
		end,
	},
	{ "<Leader>gD", lazy(kitty.launch, { cmd = "git diff", title = "Git Diff" }) },
	{ "<Leader>gl", lazy(kitty.launch, { cmd = "git-log-fzf", title = "Git Log" }) },
	{ "<Leader>gg", lazy(kitty.launch, { cmd = "lazygit", title = "Lazygit" }) },
})

legendary.autocmds({
	{
		"FileType",
		lazy(legendary.keymaps, {
			{ "q", "<C-w>q", opts = { buffer = true }, description = "Close window" },
		}),
		opts = { pattern = "help,qf,vim" },
	},
})
