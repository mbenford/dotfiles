return {
	'stevearc/dressing.nvim',
	event = 'VeryLazy',
	config = function()
		require('dressing').setup({
			input = {
				border = 'rounded',
				prompt_align = 'center',
				win_options = {
					winblend = 0,
				},
				get_config = function(opts)
					local prompt = opts.prompt or ''
					local default = opts.default or ''
					local min_width = math.max(#prompt, #default) + 10

					return {
						prompt = ' ' .. vim.trim(prompt) .. ' ',
						min_width = min_width,
						start_in_insert = vim.trim(prompt) == 'Create file' or #default == 0,
					}
				end,
			},
			select = {
				get_config = function(opts)
					local themes = require('telescope.themes')
					return {
						backend = 'telescope',
						telescope = opts.kind == 'codeaction' and themes.get_cursor() or themes.get_dropdown(),
					}
				end,
			},
		})
	end,
}
