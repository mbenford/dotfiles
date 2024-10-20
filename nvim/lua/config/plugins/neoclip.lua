return {
	"AckslD/nvim-neoclip.lua",
	keys = { "<Leader>fy" },
	config = function()
		require("neoclip").setup()
		require("legendary").keymaps({
			{ "<Leader>fy", "<Cmd>Telescope neoclip<CR>", description = "" },
		})
	end,
}
