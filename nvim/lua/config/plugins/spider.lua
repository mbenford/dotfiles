return {
	"chrisgrieser/nvim-spider",
	keys = {
		{
			"w",
			function()
				require("spider").motion("w")
			end,
			mode = { "n", "o", "x" },
			desc = "Forward to start of word",
		},
		{
			"e",
			function()
				require("spider").motion("e")
			end,
			mode = { "n", "o", "x" },
			desc = "Forward to end of word",
		},
		{
			"b",
			function()
				require("spider").motion("b")
			end,
			mode = { "n", "o", "x" },
			desc = "Backward to start of word",
		},
		{
			"ge",
			function()
				require("spider").motion("ge")
			end,
			mode = { "n", "o", "x" },
			desc = "Backward to end of word",
		},
	},
}
