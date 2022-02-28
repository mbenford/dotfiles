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
})

local builtin = require('telescope.builtin')
local function project_files(opts)
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

local map = require('utils.map')
local themes = require('plugins.telescope-themes')
map.n('<leader>ff', function() project_files(themes.default()) end)
map.n('<leader>fg', function() builtin.live_grep(themes.default()) end)
map.n('<leader>fb', function() builtin.buffers(themes.default()) end)
map.n('<leader>fr', function() builtin.resume(themes.default()) end)
map.n('<leader>fo', function() builtin.oldfiles(themes.default()) end)
map.n('<leader>fhi', function() builtin.highlights(themes.default()) end)
map.n('<leader>fhs', function() builtin.search_history(themes.center()) end)
map.n('<leader>fhc', function() builtin.command_history(themes.center()) end)
map.n('<leader>fv', function() builtin.vim_options(themes.center()) end)
map.n('<leader>ft', function() builtin.filetypes(themes.center()) end)
map.n('<leader>fs', function() builtin.spell_suggest(themes.cursor()) end)

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.add({ 'TelescopeTitle', guifg = 'white', guibg = colors.cyan })
