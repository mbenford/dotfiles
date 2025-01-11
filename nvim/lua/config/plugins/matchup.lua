return {
	"andymass/vim-matchup",
	event = { "BufRead", "InsertEnter" },
	config = function()
		vim.g.matchup_matchparen_end_sign = "⟵"
		vim.g.matchup_matchparen_offscreen = {}
	end,
}
