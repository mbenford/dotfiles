return {
	'stevearc/dressing.nvim',
	event = 'VeryLazy',
	config = function()
		require('dressing').setup({
			input = {
				border = require('utils.ui').border_float,
				prompt_align = 'center',
				win_options = {
					winblend = 0,
				},
				get_config = function(opts)
					local prompt = opts.prompt or ''
					local default = opts.default or ''
					local min_width = math.max(#prompt, #default) + 10

					return {
						min_width = min_width,
						start_in_insert = vim.trim(prompt) == 'Create file' or #default == 0,
					}
				end,
			},
			select = {
				backend = { 'telescope' },
				telescope = require('config.plugins.telescope').center_theme(),
			},
		})
	end,
}
