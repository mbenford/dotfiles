return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
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
				["<esc>"] = actions.close,
				["<cr>"] = actions.select_default + actions.center,
			},
		}
		require("telescope").setup(opts)
		require("telescope").load_extension("zf-native")

		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local lazy = require("legendary.toolbox").lazy

		local function project_files(opts)
			opts = opts or {}
			if not pcall(builtin.git_files, vim.tbl_deep_extend("force", { show_untracked = true }, opts)) then
				builtin.find_files(opts)
			end
		end

		require("legendary").keymaps({
			{
				"<Leader>ff",
				project_files,
				description = "Telescope (project files)",
			},
			{
				"<Leader>fa",
				lazy(builtin.find_files, { hidden = true, no_ignore = true, no_ignore_parent = true }),
				description = "Telescope - All Files",
			},
			{
				"<leader>fo",
				builtin.oldfiles,
				description = "Telescope - Old Files",
			},
			{
				"<leader>fg",
				builtin.live_grep,
				description = "Telescope - Live Grep",
			},
			{
				"<leader>f*",
				builtin.grep_string,
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
			-- {
			-- 	'<leader>fa',
			-- 	builtin.autocommands,
			-- 	description = 'Telescope - Autocommands',
			-- },
			{
				"<leader>gb",
				builtin.git_branches,
				description = "Telescope - Git Branches",
			},
			-- { '<leader>gs', builtin.git_stash, description = '' },
			{
				"<leader>gs",
				builtin.git_status,
				description = "Telescope - Git Status",
			},
			{
				"<leader>gc",
				builtin.git_commits,
				description = "Telescope - Git Commits",
			},
			{
				"<leader>gC",
				builtin.git_bcommits,
				description = "Telescope - Git Commits of current buffer",
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
				description = "",
			},
			{
				"<leader>ls",
				lazy(builtin.lsp_document_symbols, { symbol_width = 50 }),
				description = "Telescope - LSP Document Symbols",
			},
		})
	end,
}
