local actions = require'telescope.actions'

local telescope = require'telescope'
telescope.setup{
	defaults = {
		filesize_limit = 1,
		path_display = {'smart'},
		prompt_prefix = ' ',
		selection_caret = '',
		entry_prefix = '',
		sorting_strategy = 'ascending',
		layout_strategy = 'horizontal',
		layout_config = {
			prompt_position = 'top',
		},
		mappings = {
			i = {
				['<esc>'] = actions.close
			},
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
}

telescope.load_extension('fzf')

local function project_files()
	local ok = pcall(require'telescope.builtin'.git_files)
	if not ok then require'telescope.builtin'.find_files() end
end

local map = require'map'
map.n{'<leader>j', project_files}
map.n{'<leader>f', '<cmd>Telescope live_grep<cr>'}
