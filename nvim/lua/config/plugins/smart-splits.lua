return {
	'mrjones2014/smart-splits.nvim',
	build = './kitty/install-kittens.bash',
	opts = {},
	config = function(_, opts)
		local smartsplits = require('smart-splits')
		smartsplits.setup(opts)

		local legendary = require('legendary')
		legendary.keymaps({
			{ '<A-h>', smartsplits.move_cursor_left, description = '' },
			{ '<A-j>', smartsplits.move_cursor_down, description = '' },
			{ '<A-k>', smartsplits.move_cursor_up, description = '' },
			{ '<A-l>', smartsplits.move_cursor_right, description = '' },
		})
	end,
}
