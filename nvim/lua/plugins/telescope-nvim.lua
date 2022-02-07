require('telescope').setup({
	defaults = {
		filesize_limit = 1,
		path_display = { 'smart' },
		prompt_prefix = ' ',
		selection_caret = '',
		entry_prefix = '',
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
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
})

local border = require('utils.ui').borders
local function theme(opts)
	opts = opts or {}
	local flip_columns = 150
	local flip_lines = 20
	local theme_opts = {
		theme = 'custom',
		results_title = false,
		layout_strategy = 'flex',
		layout_config = {
			prompt_position = 'top',
			flex = { flip_columns = flip_columns, flip_lines = flip_lines },
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
				border.top,
				border.right,
				border.bottom,
				' ',
				border.top,
				border.top_right,
				border.bottom_right,
				border.bottom,
			},
		},
	}

	local is_vertical = vim.o.columns < flip_columns and vim.o.lines > flip_lines
	if is_vertical then
		theme_opts.layout_config.mirror = true
		theme_opts.borderchars.results = {
			border.top,
			border.right,
			' ',
			border.left,
			border.top_left,
			border.top_right,
			border.right,
			border.left,
		}
		theme_opts.borderchars.preview = {
			border.top,
			border.right,
			border.bottom,
			border.left,
			border.top_left,
			border.top_right,
			border.bottom_right,
			border.bottom_left,
		}
	end

	return vim.tbl_deep_extend('force', theme_opts, opts)
end

local builtin = require('telescope.builtin')
local function project_files(opts)
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

local map = require('utils.map')
map.n({ '<leader>ff', function() project_files(theme()) end, })
map.n({ '<leader>fg', function() builtin.live_grep(theme()) end, })
map.n({ '<leader>fb', function() builtin.buffers(theme()) end, })
map.n({ '<leader>fr', function() builtin.resume(theme()) end, })
map.n({ '<leader>fo', function() builtin.oldfiles(theme()) end, })

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.add({ 'TelescopeTitle', guifg = 'white', guibg = colors.cyan })
