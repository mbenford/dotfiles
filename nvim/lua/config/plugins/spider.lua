return {
	"chrisgrieser/nvim-spider",
	event = "BufRead",
	keys = {
		{
			"w",
			function()
				require("spider").motion("w")
			end,
			mode = { "n", "o", "x" },
			desc = "",
		},
		{
			"e",
			function()
				require("spider").motion("e")
			end,
			mode = { "n", "o", "x" },
			desc = "",
		},
		{
			"b",
			function()
				require("spider").motion("b")
			end,
			mode = { "n", "o", "x" },
			desc = "",
		},
		{
			"ge",
			function()
				require("spider").motion("ge")
			end,
			mode = { "n", "o", "x" },
			desc = "",
		},
	},
}
