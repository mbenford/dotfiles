require('fidget').setup({
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
})
