return {
	"carbon-steel/detour.nvim",
	config = function()
		vim.keymap.set("n", "<c-w><enter>", ":Detour<cr>")
		vim.keymap.set("n", "<c-w>.", ":DetourCurrentWindow<cr>")
	end,
}
