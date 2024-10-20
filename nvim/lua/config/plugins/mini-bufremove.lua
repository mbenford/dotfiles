return {
	"echasnovski/mini.bufremove",
	version = false,
	event = { "BufRead", "BufNew" },
	opts = {},
	config = function(_, opts)
		local mini_bufremove = require("mini.bufremove")
		mini_bufremove.setup(opts)

		require("legendary").keymaps({
			{ "<Leader>xx", mini_bufremove.delete, description = "Unload current buffer" },
		})
	end,
}
