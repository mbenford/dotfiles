return {
	"zbirenbaum/copilot.lua",
	cond = vim.fn.system("which node") ~= "",
	event = "InsertEnter",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
	},
}
