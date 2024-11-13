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
			local lazy = require("utils.lazy")
			require("which-key").add({
				{ "<leader>gp", gitsigns.preview_hunk, buffer = true, desc = "Preview current hunk" },
				{ "<leader>gr", gitsigns.reset_hunk, buffer = true, desc = "Reset current hunk" },
				{ "<leader>gb", gitsigns.blame_line, buffer = true, desc = "Show blame for current buffer" },
				{ "<leader>gB", gitsigns.blame, buffer = true, desc = "Show blame for current buffer" },
				{
					"<leader>gq",
					gitsigns.setqflist,
					buffer = true,
					desc = "Populate the quickfix list with hunks",
				},
				{
					"[g",
					lazy(gitsigns.nav_hunk, "last"),
					buffer = true,
					desc = "Jump to previous hunk in current buffer",
				},
				{
					"]g",
					lazy(gitsigns.nav_hunk, "next"),
					buffer = true,
					desc = "Jump to next hunk in current buffer",
				},
			})
		end,
	},
}
