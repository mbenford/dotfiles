return {
	'j-hui/fidget.nvim',
	enabled = false,
	tag = 'legacy',
	event = { 'LspAttach' },
	opts = {
		text = {
			spinner = 'dots_scrolling',
			done = '',
		},
		window = {
			blend = 0,
		},
		fmt = {
			stack_upwards = false,
		},
		sources = {
			['null-ls'] = {
				ignore = true,
			},
		},
	},
}
