local M = {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'natecraddock/telescope-zf-native.nvim',
 },
}

local border = require('utils.ui').borders

function M.config()
	local actions = require('telescope.actions')

	require('telescope').setup({
		defaults = {
			filesize_limit = 1,
			sorting_strategy = 'ascending',
			mappings = {
				i = {
					['<esc>'] = actions.close,
					['<cr>'] = actions.select_default + actions.center,
				},
			},
			prompt_prefix = '  ',
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
	local lazy = require('legendary.toolbox').lazy
	require('legendary').keymaps({
		{ '<leader>ff', M.project_files, description = '' },
		{ '<leader>fo', builtin.oldfiles, description = '' },
		{ '<leader>fg', builtin.live_grep, description = '' },
		{ '<leader>fb', builtin.buffers, description = '' },
		{ '<leader>fr', builtin.resume, description = '' },
		{ '<leader>fd', builtin.diagnostics, description = '' },
		{ '<leader>;', builtin.commands, description = '' },
		{ '<leader>/', builtin.current_buffer_fuzzy_find, description = '' },
		{ '<leader>fhi', builtin.highlights, description = '' },
		{ '<leader>fhs', lazy(builtin.search_history, M.center_theme()), description = '' },
		{ '<leader>fhc', lazy(builtin.command_history, M.center_theme()), description = '' },
		{ '<leader>fv', lazy(builtin.vim_options, M.center_theme()), description = '' },
		{ '<leader>ft', lazy(builtin.filetypes, M.center_theme()), description = '' },
		{ '<leader>fs', lazy(builtin.spell_suggest, M.cursor_theme()), description = '' },
		{ '<leader>fa', builtin.autocommands, description = '' },
		{ '<leader>gb', builtin.git_branches, description = '' },
		-- { '<leader>gs', builtin.git_stash, description = '' },
		{ '<leader>gs', M.git_status, description = '' },
		{ '<leader>gc', builtin.git_commits, description = '' },
		{ '<leader>ld', builtin.lsp_definitions, description = '' },
		{ '<leader>li', builtin.lsp_implementations, description = '' },
		{ '<leader>lr', lazy(builtin.lsp_references, { include_declaration = false, show_line = false }), description = '' },
		{ '<leader>ls', lazy(builtin.lsp_document_symbols, { symbol_width = 50 }), description = '' },
	})

	local colors = require('onedark.colors')
	local hl = require('utils.highlight')
	hl.set('TelescopeTitle', { fg = 'white', bg = colors.cyan })
end

function M.project_files(opts)
	opts = opts or {}
	local builtin = require('telescope.builtin')
	if not pcall(builtin.git_files, vim.tbl_deep_extend('force', { show_untracked = true }, opts)) then
		builtin.find_files(opts)
	end
end

function M.git_status(opts)
	opts = opts or {}
	opts.previewer = require('telescope.previewers').new_termopen_previewer({
		title = 'Diff Preview',
		get_command = function(entry)
			if entry.status == 'D ' then
				return { 'git', 'show', 'HEAD:' .. entry.value }
			end

			if entry.status == '??' then
				return { 'bat', '--plain', '--paging=always', entry.value }
			end

			return {
				'git',
				'-c',
				'delta.pager=less -R',
				'-c',
				'delta.file-style=omit',
				'diff',
				entry.value,
			}
		end,
	})

	require('telescope.builtin').git_status(opts)
end

function M.center_theme(opts)
	opts = opts or {}

	local theme_opts = {
		theme = 'center',
		layout_strategy = 'center',
		layout_config = { width = 0.3, height = 0.4 },
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
	}

	return vim.tbl_deep_extend('force', theme_opts, opts)
end

function M.cursor_theme(opts)
	opts = opts or {}

	local theme_opts = {
		theme = 'cursor',
		prompt_title = false,
		previewer = false,
		layout_strategy = 'cursor',
		layout_config = { width = 0.2, height = 0.3 },
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
	}

	return vim.tbl_deep_extend('force', theme_opts, opts)
end

return M
