return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{
					sign = {
						namespace = { "gitsigns" },
						colwidth = 1,
						auto = true,
					},
				},
				{
					sign = {
						name = { "Dap.*" },
						colwidth = 2,
						auto = true,
					},
				},
				{
					sign = {
						name = { ".*" },
						maxwidth = 2,
						colwidth = 1,
						auto = true,
					},
				},
				{ text = { builtin.lnumfunc, " " } },
			},
		})
	end,
}
