return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
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
		},
		pickers = {
			oldfiles = {
				only_cwd = true,
			},
			diagnostics = {
				bufnr = 0,
			},
		},
	},
	config = function(_, opts)
		local actions = require("telescope.actions")
		opts.defaults.mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<CR>"] = actions.select_default + actions.center,
			},
		}
		require("telescope").setup(opts)
		require("telescope").load_extension("zf-native")

		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		local lazy = require("utils.lazy")
		require("which-key").add({
			{
				"<Leader>ff",
				builtin.find_files,
				desc = "Telescope - Files",
			},
			{
				"<Leader>fa",
				lazy(
					builtin.find_files,
					{ prompt_title = "Find Files (ALL)", hidden = true, no_ignore = true, no_ignore_parent = true }
				),
				desc = "Telescope - All Files",
			},
			{
				"<leader>fo",
				builtin.oldfiles,
				desc = "Telescope - Old Files",
			},
			{
				"<leader>fg",
				lazy(builtin.live_grep, { additional_args = { "--fixed-strings" } }),
				desc = "Telescope - Live Grep",
			},
			{
				"<leader>fg",
				builtin.grep_string,
				mode = { "x" },
				desc = "Telescope - Grep string",
			},
			{
				"<leader>f*",
				builtin.grep_string,
				mode = { "n", "x" },
				desc = "Telescope - Grep string",
			},
			{
				"<leader>fb",
				lazy(builtin.buffers, { sort_lastused = true }),
				desc = "Telescope - Buffers",
			},
			{
				"<leader>f<leader>",
				builtin.resume,
				desc = "Telescope - Resume",
			},
			{
				"<leader>fr",
				builtin.registers,
				desc = "Telescope - Registers",
			},
			{
				"<leader>fd",
				builtin.diagnostics,
				desc = "Telescope - Diagnostics",
			},
			{
				"<leader>;",
				builtin.commands,
				desc = "Telescope - Commands",
			},
			{
				"<leader>fk",
				builtin.keymaps,
				desc = "Telescope - Commands",
			},
			{
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				desc = "Telescope - Buffer Fuzzy Find",
			},
			{
				"<leader>fhh",
				builtin.help_tags,
				desc = "Telescope - Help Tags",
			},
			{
				"<leader>fhi",
				builtin.highlights,
				desc = "Telescope - Highlights",
			},
			{
				"<leader>fhs",
				lazy(builtin.search_history, themes.get_dropdown()),
				desc = "Telescope - Search History",
			},
			{
				"<leader>fhc",
				lazy(builtin.command_history, themes.get_dropdown()),
				desc = "Telescope - Command History",
			},
			{
				"<leader>fv",
				lazy(builtin.vim_options, themes.get_dropdown()),
				desc = "Telescope - Vim Options",
			},
			{
				"<leader>ft",
				lazy(builtin.filetypes, themes.get_dropdown()),
				desc = "Telescope - File Types",
			},
			{
				"<leader>fs",
				lazy(builtin.spell_suggest, themes.get_cursor()),
				desc = "Telescope - Spell Suggestions",
			},
			{
				"<leader>fk",
				builtin.keymaps,
				desc = "Telescope - Spell Suggestions",
			},
			{
				"<leader>ld",
				builtin.lsp_definitions,
				desc = "Telescope - LSP Definitions",
			},
			{
				"<leader>li",
				builtin.lsp_implementations,
				desc = "Telescope - LSP Implementations",
			},
			{
				"<leader>lr",
				lazy(builtin.lsp_references, { include_declaration = false, show_line = false }),
				desc = "Telescope - LSP References",
			},
			{
				"<leader>ls",
				lazy(builtin.lsp_document_symbols, { symbol_width = 50 }),
				desc = "Telescope - LSP Document Symbols",
			},
			{
				"<leader>lci",
				builtin.lsp_incoming_calls,
				desc = "Telescope - LSP Incoming Calls",
			},
			{
				"<leader>lco",
				builtin.lsp_outgoing_calls,
				desc = "Telescope - LSP Outgoing Calls",
			},
		})
	end,
}
