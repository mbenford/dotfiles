return {
	'j-hui/fidget.nvim',
	config = {
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
			}
		}
	}
}
