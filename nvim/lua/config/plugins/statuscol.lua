return {
	"luukvbaal/statuscol.nvim",
	event = { "BufRead", "BufNew" },
	opts = function()
		local builtin = require("statuscol.builtin")
		return {
			ft_ignore = { "snacks_picker_preview" },
			relculright = true,
			segments = {
				{ text = { builtin.lnumfunc, " " } },
				{
					sign = {
						namespace = { "gitsigns" },
						colwidth = 1,
						auto = false,
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
			},
		}
	end,
}
