require('telescope').setup({
	defaults = {
		filesize_limit = 1,
		path_display = { 'smart' },
		prompt_prefix = ' ',
		selection_caret = '',
		entry_prefix = '',
		results_title = false,
		sorting_strategy = 'ascending',
		mappings = {
			i = {
				['<esc>'] = require('telescope.actions').close,
			},
		},
		file_ignore_patterns = {
			'%.png',
			'%.gz',
		},
	},
})

local builtin = require('telescope.builtin')
local function project_files(opts)
	if not pcall(builtin.git_files, opts) then
		builtin.find_files(opts)
	end
end
local function git_cmd(command, opts)
	pcall(builtin['git_' .. command], opts)
end

local themes = require('plugins.telescope-themes')
local lazy = require('legendary.helpers').lazy
require('legendary').bind_keymaps({
	{ '<leader>ff', lazy(project_files, themes.default()), description = '' },
	{ '<leader>fo', lazy(builtin.oldfiles, themes.default({ only_cwd = true })), description = '' },
	{ '<leader>fg', lazy(builtin.live_grep, themes.default()), description = '' },
	{ '<leader>fb', lazy(builtin.buffers, themes.default()), description = '' },
	{ '<leader>fr', lazy(builtin.resume, themes.default()), description = '' },
	{ '<leader>fd', lazy(builtin.diagnostics, themes.default({ bufnr = 0 })), description = '' },
	{ '<leader>fhi', lazy(builtin.highlights, themes.default()), description = '' },
	{ '<leader>fhs', lazy(builtin.search_history, themes.center()), description = '' },
	{ '<leader>fhc', lazy(builtin.command_history, themes.center()), description = '' },
	{ '<leader>fv', lazy(builtin.vim_options, themes.center()), description = '' },
	{ '<leader>ft', lazy(builtin.filetypes, themes.center()), description = '' },
	{ '<leader>fs', lazy(builtin.spell_suggest, themes.cursor()), description = '' },
	{ '<leader>fa', lazy(builtin.autocommands, themes.default()), description = '' },
	{ '<leader>gb', lazy(git_cmd, 'branches', themes.default()), description = '' },
	{ '<leader>gs', lazy(git_cmd, 'stash', themes.default()), description = '' },
	{ '<leader>gc', lazy(git_cmd, 'commits', themes.default()), description = '' },
	{ '<leader>ld', lazy(builtin.lsp_definitions, themes.default()), description = '' },
	{ '<leader>li', lazy(builtin.lsp_implementations, themes.default()), description = '' },
	{ '<leader>lr', lazy(builtin.lsp_references, themes.default()), description = '' },
	{ '<leader>ls', lazy(builtin.lsp_document_symbols, themes.default()), description = '' },
	{ '<leader>la', lazy(builtin.lsp_code_actions, themes.cursor()), description = '' },
})

local colors = require('onedark.colors')
vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = 'white', bg = colors.cyan })
