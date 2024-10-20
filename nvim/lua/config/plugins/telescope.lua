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
		local lazy = require("legendary.toolbox").lazy

		local legendary = require("legendary")
		legendary.keymaps({
			{
				"<Leader>ff",
				builtin.find_files,
				description = "Telescope - Files",
			},
			{
				"<Leader>fa",
				lazy(
					builtin.find_files,
					{ prompt_title = "Find Files (ALL)", hidden = true, no_ignore = true, no_ignore_parent = true }
				),
				description = "Telescope - All Files",
			},
			{
				"<leader>fo",
				builtin.oldfiles,
				description = "Telescope - Old Files",
			},
			{
				"<leader>fg",
				lazy(builtin.live_grep, { additional_args = { "--fixed-strings" } }),
				description = "Telescope - Live Grep",
			},
			{
				"<leader>fg",
				builtin.grep_string,
				mode = { "x" },
				description = "Telescope - Grep string",
			},
			{
				"<leader>f*",
				builtin.grep_string,
				mode = { "n", "x" },
				description = "Telescope - Grep string",
			},
			{
				"<leader>fb",
				lazy(builtin.buffers, { sort_lastused = true }),
				description = "Telescope - Buffers",
			},
			{
				"<leader>f<leader>",
				builtin.resume,
				description = "Telescope - Resume",
			},
			{
				"<leader>fr",
				builtin.registers,
				description = "Telescope - Registers",
			},
			{
				"<leader>fd",
				builtin.diagnostics,
				description = "Telescope - Diagnostics",
			},
			{
				"<leader>;",
				builtin.commands,
				description = "Telescope - Commands",
			},
			{
				"<leader>fk",
				builtin.keymaps,
				description = "Telescope - Commands",
			},
			{
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				description = "Telescope - Buffer Fuzzy Find",
			},
			{
				"<leader>fhh",
				builtin.help_tags,
				description = "Telescope - Help Tags",
			},
			{
				"<leader>fhi",
				builtin.highlights,
				description = "Telescope - Highlights",
			},
			{
				"<leader>fhs",
				lazy(builtin.search_history, themes.get_dropdown()),
				description = "Telescope - Search History",
			},
			{
				"<leader>fhc",
				lazy(builtin.command_history, themes.get_dropdown()),
				description = "Telescope - Command History",
			},
			{
				"<leader>fv",
				lazy(builtin.vim_options, themes.get_dropdown()),
				description = "Telescope - Vim Options",
			},
			{
				"<leader>ft",
				lazy(builtin.filetypes, themes.get_dropdown()),
				description = "Telescope - File Types",
			},
			{
				"<leader>fs",
				lazy(builtin.spell_suggest, themes.get_cursor()),
				description = "Telescope - Spell Suggestions",
			},
			{
				"<leader>fk",
				builtin.keymaps,
				description = "Telescope - Spell Suggestions",
			},
			{
				"<leader>ld",
				builtin.lsp_definitions,
				description = "Telescope - LSP Definitions",
			},
			{
				"<leader>li",
				builtin.lsp_implementations,
				description = "Telescope - LSP Implementations",
			},
			{
				"<leader>lr",
				lazy(builtin.lsp_references, { include_declaration = false, show_line = false }),
				description = "Telescope - LSP References",
			},
			{
				"<leader>ls",
				lazy(builtin.lsp_document_symbols, { symbol_width = 50 }),
				description = "Telescope - LSP Document Symbols",
			},
			{
				"<leader>lci",
				builtin.lsp_incoming_calls,
				description = "Telescope - LSP Incoming Calls",
			},
			{
				"<leader>lco",
				builtin.lsp_outgoing_calls,
				description = "Telescope - LSP Outgoing Calls",
			},
		})
	end,
}
