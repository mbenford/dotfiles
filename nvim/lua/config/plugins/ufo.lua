return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	event = "BufRead",
	opts = {
		open_fold_hl_timeout = 0,
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
	},
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "",
		},
		{
			"zr",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "",
		},
		{
			"zm",
			function()
				require("ufo").closeFoldsWith()
			end,
			desc = "",
		},
	},
}
