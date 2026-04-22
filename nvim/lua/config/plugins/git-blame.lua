return {
	"f-person/git-blame.nvim",
	opts = {
		enabled = false,
		date_format = "%r",
		message_template = " 󰜘 <author> (<date>) ",
		message_when_not_committed = " 󰜘 Not Committed Yet ",
		highlight_group = "GitBlame",
	},
	keys = {
		{
			"<Leader>gb",
			function()
				require("gitblame").toggle()
			end,
			desc = "Toggle blame annotations",
		},
	},
}
