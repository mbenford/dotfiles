return {
	"echasnovski/mini.surround",
	version = "*",
	event = { "BufRead", "BufNewFile" },
	opts = {
		search_method = "cover_or_next",
	},
}
