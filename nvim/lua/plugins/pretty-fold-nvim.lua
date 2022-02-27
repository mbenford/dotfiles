require('pretty-fold').setup({
	fill_char = ' ',
	sections = {
		left = { 'content' },
		right = {},
	},
	matchup_patterns = {
		{ '{', '}' },
	},
})
