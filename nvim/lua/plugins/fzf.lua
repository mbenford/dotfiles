local g = vim.g
g.fzf_layout = { window = { width = 0.7, height = 0.5, border = 'sharp' } }
g.fzf_preview_window = { 'right:50%:border-sharp' }
g.fzf_files_options = '--no-exact --tiebreak=end --reverse --prompt="> "'
g.fzf_colors = {
	fg = { 'fg', 'Normal' },
	bg = { 'bg', 'NvimTreeNormal' },
	hl = { 'fg', 'Statement' },
	['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
	['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
	['hl+'] = { 'fg', 'Statement' },
	info = { 'fg', 'PreProc' },
	border = { 'fg', 'Ignore' },
	prompt = { 'fg', 'Conditional' },
	pointer = { 'fg', 'Exception' },
	marker = { 'fg', 'Keyword' },
	spinner = { 'fg', 'Label' },
	header = { 'fg', 'Comment' },
}

local map = require('utils.map')
vim.cmd('silent !git rev-parse --is-inside-work-tree')
if vim.v.shell_error == 0 then
	map.n({ '<leader>j', ':GFiles --cached --others --exclude-standard<cr>' })
else
	map.n({ '<leader>j', ':Files<cr>' })
end

map.n({ '<leader>f', ':Rg<cr>' })
--nnoremap <silent> <leader>b :Buffers<CR>
