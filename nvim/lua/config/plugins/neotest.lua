return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-jest",
	},
	enabled = false,
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "pnpm test --",
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
			},
		})
	end,
}
