local border = require('utils.ui').borders

local M = {}
function M.default(opts)
	opts = opts or {}
	local flip_columns = 150
	local flip_lines = 40
	local theme_opts = {
		theme = 'default',
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

function M.center(opts)
	opts = opts or {}

	local theme_opts = {
		theme = "center",

		sorting_strategy = "ascending",
		results_title = false,
		previewer = false,
		layout_strategy = "center",
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

	return vim.tbl_deep_extend("force", theme_opts, opts)
end

function M.cursor(opts)
	opts = opts or {}

	local theme_opts = {
		theme = "cursor",

		sorting_strategy = "ascending",
		prompt_title = false,
		results_title = false,
		previewer = false,
		layout_strategy = "cursor",
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

	return vim.tbl_deep_extend("force", theme_opts, opts)
end

return M
