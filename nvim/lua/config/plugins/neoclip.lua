return {
	"AckslD/nvim-neoclip.lua",
	event = "VeryLazy",
	config = function()
		require("neoclip").setup()
		require("legendary").keymaps({
			{ "<Leader>fy", "<Cmd>Telescope neoclip<CR>", description = "" },
		})
	end,
}
