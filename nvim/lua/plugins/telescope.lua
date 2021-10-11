local actions = require'telescope.actions'

require'telescope'.setup{
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
}

local function project_files()
	local ok = pcall(require'telescope.builtin'.git_files)
	if not ok then require'telescope.builtin'.find_files() end
end

local map = require'utils'.map
map{'n', '<leader>j', project_files}
map{'n', '<leader>f', ':Telescope live_grep<cr>'}
