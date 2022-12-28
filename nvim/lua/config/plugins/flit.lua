return {
	'ggandor/flit.nvim',
	event = 'BufRead',
	dependencies = {
		'ggandor/leap.nvim',
	},
	config = {
		labeled_modes = 'nvo',
		multiline = false,
	}
}
