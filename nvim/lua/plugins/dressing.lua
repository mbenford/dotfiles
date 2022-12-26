return {
	'stevearc/dressing.nvim',
	config = {
		input = {
			border = require('utils.ui').border_float,
			prompt_align = 'center',
			win_options = {
				winblend = 0,
				winhighlight = 'Normal:NormalInput,FloatBorder:FloatBorderInput',
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
			telescope = require('plugins.telescope').center_theme(),
		},
	},
	init = function()
		local colors = require('onedark.colors')
		local hl = require('utils.highlight')
		hl.set('NormalInput', { bg = colors.bg0 })
		hl.set('FloatBorderInput', { fg = colors.cyan })
	end,
}
