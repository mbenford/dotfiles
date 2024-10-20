return {
	"cbochs/grapple.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		scope = "git",
		win_opts = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		local grapple = require("grapple")
		grapple.setup(opts)

		local lazy = require("legendary.toolbox").lazy
		require("legendary").keymaps({
			{ "<Leader>hh", grapple.open_tags, description = "" },
			{ "<Leader>ha", grapple.tag, description = "" },
			{ "<Leader>hd", grapple.untag, description = "" },
			{ "<Leader>hc", grapple.reset, description = "" },
			{ "<Leader>1", lazy(grapple.select, { index = 1 }), description = "" },
			{ "<Leader>2", lazy(grapple.select, { index = 2 }), description = "" },
			{ "<Leader>3", lazy(grapple.select, { index = 3 }), description = "" },
			{ "<Leader>4", lazy(grapple.select, { index = 4 }), description = "" },
		})
	end,
}
