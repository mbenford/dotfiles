return {
	"echasnovski/mini.surround",
	version = "*",
	event = { "BufRead", "InsertEnter" },
	opts = {
		search_method = "cover_or_next",
	},
}
