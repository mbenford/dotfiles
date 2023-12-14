return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.constant.alias.bool,
			},
		})

		local dial = require("dial.map")
		local lazy = require("legendary.toolbox").lazy
		require("legendary").keymaps({
			{ "<C-a>", lazy(dial.manipulate, "increment", "normal"), description = "" },
			{ "<C-x>", lazy(dial.manipulate, "decrement", "normal"), description = "" },
			{ "g<C-a>", lazy(dial.manipulate, "increment", "gnormal"), description = "" },
			{ "g<C-x>", lazy(dial.manipulate, "decrement", "gnormal"), description = "" },
			{ "<C-a>", lazy(dial.manipulate, "increment", "visual"), mode = { "v" }, description = "" },
			{ "<C-x>", lazy(dial.manipulate, "decrement", "visual"), mode = { "v" }, description = "" },
			{ "g<C-a>", lazy(dial.manipulate, "increment", "gvisual"), mode = { "v" }, description = "" },
			{ "g<C-x>", lazy(dial.manipulate, "decrement", "gvisual"), mode = { "v" }, description = "" },
		})
	end,
}
