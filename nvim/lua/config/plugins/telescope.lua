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
			find_files = { prompt_title = "Files" },
			oldfiles = { only_cwd = true, prompt_title = "Recent Files" },
			live_grep = { additional_args = { "--fixed-strings" } },
			buffers = { sort_lastused = true },
			diagnostics = { bufnr = 0 },
			lsp_references = { include_declaration = false, show_line = false },
			lsp_document_symbols = { symbol_width = 50 },
		},
	},
	init = function()
		require("which-key").add({
			{ "<Leader>f", group = "Telescope" },
		})
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("zf-native")
	end,
	keys = {
		{
			"<Leader>ff",
			"<Cmd>Telescope find_files<CR>",
			desc = "Files",
		},
		{
			"<Leader>fa",
			"<Cmd>Telescope find_files prompt_title=All\\ Files hidden=true no_ignore=true no_ignore_parent=true<CR>",
			desc = "All files",
		},
		{
			"<Leader>fo",
			"<Cmd>Telescope oldfiles<CR>",
			desc = "Recent files",
		},
		{
			"<Leader>fg",
			"<Cmd>Telescope live_grep<CR>",
			desc = "Live grep",
		},
		{
			"<Leader>fg",
			"<Cmd>Telescope grep_string<CR>",
			mode = { "x" },
			desc = "Grep string",
		},
		{
			"<Leader>f*",
			"<Cmd>Telescope grep_string<CR>",
			mode = { "n", "x" },
			desc = "Grep string",
		},
		{
			"<Leader>fb",
			"<Cmd>Telescope buffers<CR>",
			desc = "Buffers",
		},
		{
			"<Leader>f<Leader>",
			"<Cmd>Telescope resume<CR>",
			desc = "Resume last search",
		},
		{
			"<Leader>fr",
			"<Cmd>Telescope registers<CR>",
			desc = "Registers",
		},
		{
			"<Leader>fh",
			"<Cmd>Telescope help_tags<CR>",
			desc = "Help",
		},
		{
			"<Leader>fv",
			"<Cmd>Telescope vim_options<CR>",
			desc = "Vim options",
		},
		{
			"<Leader>ft",
			"<Cmd>Telescope filetypes theme=dropdown<CR>",
			desc = "Filetypes",
		},
		{
			"<Leader>fs",
			"<Cmd>Telescope spell_suggest theme=cursor<CR>",
			desc = "Spelling suggestions",
		},
		{
			"<Leader>ld",
			"<Cmd>Telescope lsp_definitions<CR>",
			desc = "LSP definitions",
		},
		{
			"<Leader>li",
			"<Cmd>Telescope lsp_implementations<CR>",
			desc = "LSP implementations",
		},
		{
			"<Leader>lr",
			"<Cmd>Telescope lsp_references<CR>",
			desc = "LSP references",
		},
		{
			"<Leader>ls",
			"<Cmd>Telescope lsp_document_symbols<CR>",
			desc = "LSP document symbols",
		},
		{
			"<Leader>lci",
			"<Cmd>Telescope lsp_incoming_calls<CR>",
			desc = "LSP incoming calls",
		},
		{
			"<Leader>lco",
			"<Cmd>Telescope lsp_outgoing_calls<CR>",
			desc = "LSP outgoing calls",
		},
	},
}
