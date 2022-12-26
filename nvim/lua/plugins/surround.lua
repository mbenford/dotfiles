return {
	'kylechui/nvim-surround',
	event = 'BufRead',
	config = {
		keymaps = {
			normal = 'gs',
			normal_cur = 'gS',
			normal_cur_line = 'gSS',
			visual = 'gs',
			change = 'gsr',
			delete = 'gsd',
		},
	}
}
