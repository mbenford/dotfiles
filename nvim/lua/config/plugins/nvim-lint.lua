return {
	'mfussenegger/nvim-lint',
	event = { 'BufRead', 'InsertEnter' },
	config = function()
		require('lint').linters_by_ft = {
			python = { 'flake8' },
		}
	end,
}
