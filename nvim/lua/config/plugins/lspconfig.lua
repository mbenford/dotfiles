return {
	"neovim/nvim-lspconfig",
	event = { "BufRead", "BufWritePost" },
	init = function()
		require("which-key").add({
			{ "<Leader>l", group = "LSP" },
		})
	end,
	config = function()
		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
