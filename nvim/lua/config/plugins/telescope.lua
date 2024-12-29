return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"natecraddock/telescope-zf-native.nvim",
	},
	opts = {
		defaults = {
			filesize_limit = 1,
			sorting_strategy = "ascending",
			scroll_strategy = "limit",
			prompt_prefix = "  ",
			selection_caret = "",
			entry_prefix = "",
			results_title = false,
			layout_strategy = "vertical",
			layout_config = {
				prompt_position = "top",
				vertical = {
					mirror = true,
				},
			},
			file_ignore_patterns = {
				"%.png",
				"%.gz",
			},
			mappings = {
				i = {
					["<Esc>"] = "close",
				},
			},
		},
		pickers = {
			oldfiles = { only_cwd = true, prompt_title = "Recent Files" },
			live_grep = { additional_args = { "--fixed-strings" } },
			buffers = { sort_lastused = true },
			diagnostics = { bufnr = 0 },
			lsp_references = { include_declaration = false, show_line = false },
			lsp_document_symbols = { symbol_width = 50 },
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("zf-native")
	end,
	keys = {
		{
			"<Leader>ff",
			"<Cmd>Telescope find_files<CR>",
			desc = "Telescope - Files",
		},
		{
			"<Leader>fa",
			"<Cmd>Telescope find_files hidden=true no_ignore=true no_ignore_parent=true<CR>",
			desc = "Telescope - All Files",
		},
		{
			"<Leader>fo",
			"<Cmd>Telescope oldfiles<CR>",
			desc = "Telescope - Recent Files",
		},
		{
			"<Leader>fg",
			"<Cmd>Telescope live_grep<CR>",
			desc = "Telescope - Live Grep",
		},
		{
			"<Leader>fg",
			"<Cmd>Telescope grep_string<CR>",
			mode = { "x" },
			desc = "Telescope - Grep string",
		},
		{
			"<Leader>f*",
			"<Cmd>Telescope grep_string<CR>",
			mode = { "n", "x" },
			desc = "Telescope - Grep string",
		},
		{
			"<Leader>fb",
			"<Cmd>Telescope buffers<CR>",
			desc = "Telescope - Buffers",
		},
		{
			"<Leader>f<Leader>",
			"<Cmd>Telescope resume<CR>",
			desc = "Telescope - Resume",
		},
		{
			"<Leader>fr",
			"<Cmd>Telescope registers<CR>",
			desc = "Telescope - Registers",
		},
		{
			"<Leader>fh",
			"<Cmd>Telescope help_tags<CR>",
			desc = "Telescope - Help",
		},
		-- {
		-- 	"<Leader>fhs",
		-- 	"<Cmd>Telescope search_history<CR>",
		-- 	desc = "Telescope - Search History",
		-- },
		-- {
		-- 	"<Leader>fhc",
		-- 	"<Cmd>Telescope command_history<CR>",
		-- 	desc = "Telescope - Command History",
		-- },
		{
			"<Leader>fv",
			"<Cmd>Telescope vim_options<CR>",
			desc = "Telescope - Vim Options",
		},
		{
			"<Leader>ft",
			"<Cmd>Telescope filetypes theme=dropdown<CR>",
			desc = "Telescope - File Types",
		},
		{
			"<Leader>fs",
			"<Cmd>Telescope spell_suggest theme=cursor<CR>",
			desc = "Telescope - Spell Suggestions",
		},
		{
			"<Leader>ld",
			"<Cmd>Telescope lsp_definitions<CR>",
			desc = "Telescope - LSP Definitions",
		},
		{
			"<Leader>li",
			"<Cmd>Telescope lsp_implementations<CR>",
			desc = "Telescope - LSP Implementations",
		},
		{
			"<Leader>lr",
			"<Cmd>Telescope lsp_references<CR>",
			desc = "Telescope - LSP References",
		},
		{
			"<Leader>ls",
			"<Cmd>Telescope lsp_document_symbols<CR>",
			desc = "Telescope - LSP Document Symbols",
		},
		{
			"<Leader>lci",
			"<Cmd>Telescope lsp_incoming_calls<CR>",
			desc = "Telescope - LSP Incoming Calls",
		},
		{
			"<Leader>lco",
			"<Cmd>Telescope lsp_outgoing_calls<CR>",
			desc = "Telescope - LSP Outgoing Calls",
		},
	},
}
