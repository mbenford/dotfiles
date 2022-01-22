local actions = require('telescope.actions')

local telescope = require('telescope')
telescope.setup({
	defaults = {
		filesize_limit = 1,
		path_display = { 'smart' },
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
				['<esc>'] = actions.close,
			},
		},
		file_ignore_patterns = {
			'%.png',
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

telescope.load_extension('fzf')

local function project_files()
	local ok = pcall(require('telescope.builtin').git_files)
	if not ok then
		require('telescope.builtin').find_files()
	end
end

local map = require('utils.map')
map.n({ '<leader>ff', project_files })
map.n({ '<leader>fg', '<cmd>Telescope live_grep<cr>' })
map.n({ '<leader>fb', '<cmd>Telescope buffers<cr>' })
map.n({ '<leader>fr', '<cmd>Telescope resume<cr>' })
map.n({ '<leader>fo', '<cmd>Telescope oldfiles<cr>' })
