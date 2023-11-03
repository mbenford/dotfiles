return {
	'kosayoda/nvim-lightbulb',
	dependencies = 'antoinemadec/FixCursorHold.nvim',
	event = 'LspAttach',
	opts = {
		link_highlights = false,
		autocmd = { enabled = true, events = { 'CursorHold' } },
		sign = { enabled = true, text = '󰌵' },
	},
}
