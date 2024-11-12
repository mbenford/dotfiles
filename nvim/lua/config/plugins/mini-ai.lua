return {
	"echasnovski/mini.ai",
	version = "*",
	event = { "BufRead", "InsertEnter" },
	config = function()
		local mini_ai = require("mini.ai")
		local gen_spec = mini_ai.gen_spec
		mini_ai.setup({
			custom_textobjects = {
				F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
			},
		})
	end,
}
