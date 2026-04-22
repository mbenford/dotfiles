return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.decimal_int,
				augend.constant.alias.bool,
				augend.constant.alias.Bool,
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%d/%m/%Y"],

				augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
				augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
				augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true }),
				augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
			},
		})
	end,
	keys = {
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			desc = "Add to the number or alphabetic character at or after the cursor",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "normal")
			end,
			desc = "Subtract from the number or alphabetic character at or after the cursor",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gnormal")
			end,
			desc = "Add to the number or alphabetic character at or after the cursor",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gnormal")
			end,
			desc = "",
		},
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "visual")
			end,
			mode = "v",
			desc = "",
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("decrement", "visual")
			end,
			mode = "v",
			desc = "",
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gvisual")
			end,
			mode = "v",
			desc = "",
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gvisual")
			end,
			mode = "v",
			desc = "",
		},
	},
}
