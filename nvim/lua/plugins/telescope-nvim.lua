local border = require('utils.ui').borders
require('telescope').setup({
	defaults = {
		filesize_limit = 1,
		path_display = { 'smart' },
		sorting_strategy = 'ascending',
		mappings = {
			i = {
				['<esc>'] = require('telescope.actions').close,
			},
		},
		prompt_prefix = ' ',
		selection_caret = '',
		entry_prefix = '',
		results_title = false,
		layout_strategy = 'vertical',
		layout_config = {
			prompt_position = 'top',
			mirror = true,
		},
		borderchars = {
			prompt = {
				border.top,
				border.right,
				' ',
				border.left,
				border.top_left,
				border.top_right,
				border.right,
				border.left,
			},
			results = {
				border.top,
				border.right,
				border.bottom,
				border.left,
				border.top_left,
				border.top_right,
				border.bottom_right,
				border.bottom_left,
			},
			preview = {
				' ',
				border.right,
				border.bottom,
				border.left,
				border.left,
				border.right,
				border.bottom_right,
				border.bottom_left,
			},
		},
		file_ignore_patterns = {
			'%.png',
			'%.gz',
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
})

local builtin = require('telescope.builtin')
local function project_files(opts)
	if not pcall(builtin.git_files, opts) then
		builtin.find_files(opts)
	end
end

local themes = require('plugins.telescope-themes')
local lazy = require('legendary.helpers').lazy
require('legendary').bind_keymaps({
	{ '<leader>ff', project_files, description= '' },
	{ '<leader>fo', builtin.oldfiles, description = '' },
	{ '<leader>fg', builtin.live_grep, description = '' },
	{ '<leader>fb', builtin.buffers, description = '' },
	{ '<leader>fr', builtin.resume, description = '' },
	{ '<leader>fd', builtin.diagnostics, description = '' },
	{ '<leader>fhi', builtin.highlights, description = '' },
	{ '<leader>fhs', lazy(builtin.search_history, themes.center()), description = '' },
	{ '<leader>fhc', lazy(builtin.command_history, themes.center()), description = '' },
	{ '<leader>fv', lazy(builtin.vim_options, themes.center()), description = '' },
	{ '<leader>ft', lazy(builtin.filetypes, themes.center()), description = '' },
	{ '<leader>fs', lazy(builtin.spell_suggest, themes.cursor()), description = '' },
	{ '<leader>fa', builtin.autocommands, description = '' },
	{ '<leader>gb', builtin.git_branches, description = '' },
	{ '<leader>gs', builtin.git_stash, description = '' },
	{ '<leader>gc', builtin.git_commits, description = '' },
	{ '<leader>ld', builtin.lsp_definitions, description = '' },
	{ '<leader>li', builtin.lsp_implementations, description = '' },
	{ '<leader>lr', builtin.lsp_references, description = '' },
	{ '<leader>ls', builtin.lsp_document_symbols, description = '' },
	{ '<leader>la', lazy(builtin.lsp_code_actions, themes.cursor()), description = '' },
})

local colors = require('onedark.colors')
vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = 'white', bg = colors.cyan })
