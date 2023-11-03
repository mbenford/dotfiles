return {
	'wellle/targets.vim',
	event = 'BufRead',
	config = function()
		vim.cmd([[
			autocmd User targets#mappings#user call targets#mappings#extend({
				\ 'a': {'argument': [{'o': '[({[]', 'c': '[]})]', 's': ','}]}
				\ })
		]])
	end,
}
