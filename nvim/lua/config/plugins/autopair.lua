return {
	"windwp/nvim-autopairs",
	-- dependencies = {
	-- 	"hrsh7th/nvim-cmp",
	-- },
	event = "InsertEnter",
	opts = {
		enable_moveright = true,
	},
	config = function(_, opts)
		require("nvim-autopairs").setup(opts)
		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- local cmp = ;equire("cmp")
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
