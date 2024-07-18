return {
	"folke/trouble.nvim",
	event = "BufRead",
	opts = {
		use_diagnostic_signs = true,
		focus = true,
	},
	config = function(_, opts)
		local trouble = require("trouble")
		trouble.setup(opts)

		local lazy = require("legendary.toolbox").lazy
		require("legendary").keymaps({
			{ "<Leader>tt", lazy(trouble.open, "todo") },
			{ "<Leader>td", lazy(trouble.open, "diagnostics") },
		})
	end,
}
