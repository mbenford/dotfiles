return {
	"andymass/vim-matchup",
	event = { "BufRead", "InsertEnter" },
	config = function()
		vim.g.matchup_matchparen_end_sign = "⟵"
	end,
}
