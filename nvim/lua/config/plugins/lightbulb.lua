return {
	"kosayoda/nvim-lightbulb",
	enabled = false,
	dependencies = "antoinemadec/FixCursorHold.nvim",
	event = "LspAttach",
	opts = {
		link_highlights = false,
		autocmd = { enabled = true, events = { "CursorHold" } },
		sign = { enabled = true, text = "󰌵" },
	},
}
