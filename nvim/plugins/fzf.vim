let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.5, 'border': 'sharp' } }
let g:fzf_preview_window = ['right:50%:border-sharp']
let g:fzf_files_options = '--no-exact --tiebreak=end --reverse --prompt="> "'
let g:fzf_colors = {
	\ 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'NvimTreeNormal'],
	\ 'hl':      ['fg', 'Statement'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment']
	\ }
