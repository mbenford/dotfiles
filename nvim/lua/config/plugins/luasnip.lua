return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"nvim-cmp",
	},
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")
		luasnip.config.setup({
			history = true,
		})

		require("legendary").keymaps({
			{
				"<C-j>",
				function()
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					end
				end,
				mode = { "i", "s" },
				description = "Expand snippet or jump to next placeholder",
			},
			{
				"<C-k>",
				function()
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					end
				end,
				mode = { "i", "s" },
				description = "Jump to previous placeholder",
			},
		})
	end,
}
