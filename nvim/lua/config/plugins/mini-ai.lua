return {
	"echasnovski/mini.ai",
	version = "*",
	event = { "BufRead", "BufNewFile" },
	opts = function()
		local mini_ai = require("mini.ai")
		local spec = mini_ai.gen_spec
		return {
			custom_textobjects = {
				F = spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				o = spec.treesitter({
					a = { "@conditional.outer", "@loop.outer" },
					i = { "@conditional.inner", "@loop.inner" },
				}),
				B = function()
					local from = { line = 1, col = 1 }
					local to = {
						line = vim.fn.line("$"),
						col = math.max(vim.fn.getline("$"):len(), 1),
					}
					return { from = from, to = to }
				end,
			},
		}
	end,
}
