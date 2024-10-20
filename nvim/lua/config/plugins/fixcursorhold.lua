return {
	"antoinemadec/FixCursorHold.nvim",
	event = { "BufRead", "InsertEnter" },
	config = function()
		vim.g.cursorhold_updatetime = 100
	end,
}
