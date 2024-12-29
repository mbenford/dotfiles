return {
	"ray-x/lsp_signature.nvim",
	event = { "BufRead", "InsertEnter" },
	enabled = false,
	opts = {
		hint_enable = false,
		fix_pos = true,
		handler_opts = {
			border = "rounded",
		},
	},
}
