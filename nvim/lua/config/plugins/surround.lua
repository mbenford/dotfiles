return {
	"kylechui/nvim-surround",
	enabled = false,
	event = "BufRead",
	opts = {
		keymaps = {
			normal = "<C-s>",
			normal_cur = "<C-S-s>",
			visual = "<C-s>",
			change = "<C-s>r",
			delete = "<C-s>d",
		},
	},
}
