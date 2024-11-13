local lazy = require("utils.lazy")
local apply_zz = require("utils.misc").apply_zz
local kitty = require("utils.kitty")

require("which-key").add({
	{ "<Space>", "<Nop>", mode = { "n", "x" } },
	{ ";", ":", mode = { "n", "x" }, silent = false, desc = "Command line mode" },
	{ "H", "^", mode = { "n", "x", "o" }, remap = true, desc = "Alias for ^" },
	{ "L", "g_", mode = { "n", "x", "o" }, remap = true, desc = "Alias for g_" },
	{ "M", "%", mode = { "n", "x", "o" }, remap = true, desc = "Alias for %" },
	{ "Q", '<Cmd>execute "noautocmd normal! " . v:count1 . "@" . getcharstr()<cr>', desc = "Alias for @" },
	{ "<", "<gv", mode = { "x" }, desc = "Shift left and keep selection" },
	{ ">", ">gv", mode = { "x" }, desc = "Shift right and keep selection" },
	{ "U", "<C-r>", desc = "Redo" },
	{ "j", "gj", desc = "Go down (non-linewise)" },
	{ "k", "gk", desc = "Go up (non-linewise)" },
	{ "n", "nzz", desc = "Go to next occurrence and center" },
	{ "N", "Nzz", desc = "Go to previous occurrence and center" },
	{ "gg", "ggzz", desc = "Go to line (default first line) and center" },
	{ "G", "Gzz", desc = "Go to line (default last line) and center" },
	{ "g;", "g;zz", desc = "Go to last edit and center" },
	{ "<C-d>", "<C-d>zz", desc = "Scroll down and center" },
	{ "<C-u>", "<C-u>zz", desc = "Scroll up and center" },
	{ "*", "*zz", desc = "Search forward and center" },
	{ "#", "#zz", desc = "Search backward and center" },
	{ "J", "maJ`a", desc = "Join lines and keep the cursor at its position" },
	{ "x", '"_x', mode = { "n", "x" }, desc = "Same as x but uses the black hole register" },
	{ "X", '"_dd', desc = "Delete the current line into the black hole register" },
	{ "<Tab>", "<C-^>zz", desc = "Switch to the alternate buffer" },
	{ "<C-p>", "<Cmd>put<CR>", desc = 'Put the text from register " on the line below' },
	{ "<C-S-p>", "<Cmd>put!<CR>", desc = 'Put the text from register " on the line above' },
	{ "<C-q>", "<Cmd>qa<CR>", desc = "Exit" },
	{ "<C-S-q>", "<Cmd>qa!<CR>", desc = "Exit without saving" },
	{
		"dd",
		function()
			return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
		end,
		expr = true,
		desc = "Same as dd but uses the black hole register for empty lines",
	},
	{ "<Leader>w", "<Cmd>silent! wa<CR>", desc = "Write all changed buffers" },
	{ "<Leader>i", "i<Space><Esc>r", desc = "Insert one character" },
	{ "<Leader>o", "mao<Esc>`a", desc = "Insert empty line below" },
	{ "<Leader>O", "maO<Esc>`a", desc = "Insert empty line above" },
	{ "<Leader>y", '"+yy', desc = "Yank current line to clipboard" },
	{ "<Leader>y", '"+y', mode = { "x" }, desc = "Yank selected lines to clipboard" },
	{ "<Leader>p", '"+p', desc = "Paste from clipboard after the cursor" },
	{ "<Leader>P", '"+P', desc = "Paste from clipboard before the cursor" },
	{ "cn", "*``micgn", desc = "Change the word at the cursor and search next occurrences" },
	{ "cs", "*``:%s/<C-r><C-w>//g<Left><Left>", desc = "Substitute all occurrences of the word at the cursor" },
	{ "<C-Down>", "<Cmd>move +1<CR>==", desc = "Move the current line down" },
	{ "<C-Up>", "<Cmd>move -2<CR>==", desc = "Move the current line up" },
	{ "<C-Down>", ":m '>+1<CR>gv=gv", mode = { "v" }, desc = "Move selected lines line down" },
	{ "<C-Up>", ":m '<-2<CR>gv=gv", mode = { "v" }, desc = "Move selected lines line up" },
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
	{ "gct", "gcoTODO: ", remap = true, desc = "Add a TODO comment" },
	{ "gcn", "gcoNOTE: ", remap = true, desc = "Add a NOTE comment" },
	{ "gcf", "gcoFIXME: ", remap = true, desc = "Add a FIXME comment" },
	{ "<C-w><S-n>", "<Cmd>vnew<CR>", desc = "Resize window left" },
	{ "<C-w><Tab>", "<C-w>^", desc = "Resize window left" },
	{
		"<Up>",
		function()
			return vim.fn.pumvisible() == 1 and "<Left>" or "<Up>"
		end,
		mode = { "c" },
		expr = true,
		silent = false,
		desc = "Up when PMenu is visible",
	},
	{
		"<Down>",
		function()
			return vim.fn.pumvisible() == 1 and "<Right>" or "<Down>"
		end,
		mode = { "c" },
		expr = true,
		silent = false,
		desc = "Down when PMenu is visible",
	},
	{ "<Leader>k", vim.diagnostic.open_float, desc = "Open diagnostic window for current line" },
	{ "[d", apply_zz(vim.diagnostic.goto_prev), desc = "Go to previous diagnostic" },
	{ "]d", apply_zz(vim.diagnostic.goto_next), desc = "Go to next diagnostic" },
	{
		"[e",
		apply_zz(lazy(vim.diagnostic.goto_prev, { severity = vim.diagnostic.severity.ERROR })),
		desc = "Go to previous diagnostic error",
	},
	{
		"]e",
		apply_zz(lazy(vim.diagnostic.goto_next, { severity = vim.diagnostic.severity.ERROR })),
		desc = "Go to next diagnostic error",
	},
	{ "<Leader>q", "<Cmd>botright copen<CR>", desc = "Open Quickfix window" },
	{ "[q", "<Cmd>cprev<CR>zz", desc = "Go to previous item on quickfix list" },
	{ "]q", "<Cmd>cnext<CR>zz", desc = "Go to next item on quickfix list" },
	{ "[l", "<Cmd>lprev<CR>zz", desc = "Go to previous item on location list" },
	{ "]l", "<Cmd>lnext<CR>zz", desc = "Go to next item on location list" },
	{ "<Esc>", "<Cmd>nohlsearch<CR><Esc>", mode = { "n" }, desc = "Clear search highlight" },

	-- Toggles
	{ "<LocalLeader>tn", "<Cmd>set number!<CR>", desc = "Toggle numbers" },
	{ "<LocalLeader>tr", "<Cmd>set relativenumber!<CR>", desc = "Toggle relative numbers" },
	{ "<LocalLeader>tw", "<Cmd>set wrap!<CR>", desc = "Toggle line wrap" },
	{ "<LocalLeader>th", "<Cmd>set hlsearch!<CR>", desc = "Toggle search highlight" },
	{ "<LocalLeader>ts", "<Cmd>set spell!<CR>", desc = "Toggle spell checking" },

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
