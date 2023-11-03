return {
	'chrisgrieser/nvim-spider',
	event = { 'BufEnter', 'InsertEnter' },
	config = function()
		local spider = require('spider')
		local lazy = require('legendary.toolbox').lazy
		require('legendary').keymaps({
			{ 'w', lazy(spider.motion, 'w'), mode = { 'n', 'o', 'x' }, description = '' },
			{ 'e', lazy(spider.motion, 'e'), mode = { 'n', 'o', 'x' }, description = '' },
			{ 'b', lazy(spider.motion, 'b'), mode = { 'n', 'o', 'x' }, description = '' },
			{ 'ge', lazy(spider.motion, 'ge'), mode = { 'n', 'o', 'x' }, description = '' },
		})
	end,
}
