return {
	"echasnovski/mini.surround",
	version = false,
	event = { "BufRead", "InsertEnter" },
	opts = {
		search_method = "cover_or_next",
	},
	config = function(_, opts)
		require("mini.surround").setup(opts)
		vim.keymap.set({ "n", "x" }, "s", "<Nop>")
		vim.keymap.set({ "n", "x" }, "S", "<Nop>")
	end,
}
