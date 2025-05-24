return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "fredrikaverpil/neotest-golang", version = "*" },
	},
	enabled = false,
	opts = function()
		return {
			adapters = {
				require("neotest-golang")({}),
			},
		}
	end,
	keys = {
		{
			"<Leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Trouble (todo)",
		},
	},
	-- config = function()
	-- 	require("neotest").setup({
	-- 		adapters = {
	-- 			require("neotest-jest")({
	-- 				jestCommand = "pnpm test --",
	-- 				cwd = function(path)
	-- 					return vim.fn.getcwd()
	-- 				end,
	-- 			}),
	-- 		},
	-- 	})
	-- end,
}
