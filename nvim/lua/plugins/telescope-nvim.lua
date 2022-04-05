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
local map = require('utils.map').map
local themes = require('plugins.telescope-themes')
local apply = require('utils.function').apply
local papply = require('utils.function').papply

local function project_files(opts)
	if not pcall(builtin.git_files, opts) then
		builtin.find_files(opts)
	end
end

map('n', '<leader>ff', apply(project_files, themes.default()))
map('n', '<leader>fg', apply(builtin.live_grep, themes.default()))
map('n', '<leader>fb', apply(builtin.buffers, themes.default()))
map('n', '<leader>fr', apply(builtin.resume, themes.default()))
map('n', '<leader>fo', apply(builtin.oldfiles, themes.default()))
map('n', '<leader>fhi', apply(builtin.highlights, themes.default()))
map('n', '<leader>fhs', apply(builtin.search_history, themes.center()))
map('n', '<leader>fhc', apply(builtin.command_history, themes.center()))
map('n', '<leader>fv', apply(builtin.vim_options, themes.center()))
map('n', '<leader>ft', apply(builtin.filetypes, themes.center()))
map('n', '<leader>fs', apply(builtin.spell_suggest, themes.cursor()))
map('n', '<leader>gb', papply(builtin.git_branches, themes.default()))
map('n', '<leader>gs', papply(builtin.git_stash, themes.default()))
map('n', '<leader>gc', papply(builtin.git_commits, themes.default()))
map('n', '<leader>ld', apply(builtin.lsp_definitions, themes.default()))
map('n', '<leader>li', apply(builtin.lsp_implementations, themes.default()))
map('n', '<leader>lr', apply(builtin.lsp_references, themes.default()))
map('n', '<leader>ls', apply(builtin.lsp_document_symbols, themes.default()))
map('n', '<leader>la', apply(builtin.lsp_code_actions, themes.cursor()))

local colors = require('onedark.colors')
local hl = require('utils.highlight')
hl.add({ 'TelescopeTitle', guifg = 'white', guibg = colors.cyan })
