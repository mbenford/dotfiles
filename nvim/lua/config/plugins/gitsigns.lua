local signs = {
	add = { text = "▍" },
	change = { text = "▍" },
	delete = { text = "▍" },
	topdelete = { text = "▍" },
	changedelete = { text = "▍" },
	untracked = { text = "▍" },
}

return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	opts = {
		signs = signs,
		signs_staged = signs,
		preview_config = {
			border = "rounded",
		},
		trouble = false,
		on_attach = function()
			local gitsigns = require("gitsigns")
			local lazy = require("legendary.toolbox").lazy
			require("legendary").keymaps({
				{ "<leader>gp", gitsigns.preview_hunk, opts = { buffer = true }, description = "Preview current hunk" },
				{ "<leader>gr", gitsigns.reset_hunk, opts = { buffer = true }, description = "Reset current hunk" },
				{ "<leader>gb", gitsigns.blame_line, opts = { buffer = true }, description = "Show blame for current buffer" },
				{ "<leader>gB", gitsigns.blame, opts = { buffer = true }, description = "Show blame for current buffer" },
				{
					"<leader>gq",
					gitsigns.setqflist,
					opts = { buffer = true },
					description = "Populate the quickfix list with hunks",
				},
				{
					"[g",
					lazy(gitsigns.nav_hunk, "last"),
					opts = { buffer = true },
					description = "Jump to previous hunk in current buffer",
				},
				{
					"]g",
					lazy(gitsigns.nav_hunk, "next"),
					opts = { buffer = true },
					description = "Jump to next hunk in current buffer",
				},
			})
		end,
	},
}
