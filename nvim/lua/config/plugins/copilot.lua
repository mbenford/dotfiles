return {
	'zbirenbaum/copilot.lua',
	event = { 'BufRead', 'InsertEnter' },
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
	},
}
