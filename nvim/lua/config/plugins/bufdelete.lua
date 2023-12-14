return {
	"famiu/bufdelete.nvim",
	enabled = false,
	event = "BufRead",
	config = function()
		require("legendary").keymaps({
			{ "<Leader>q<Leader>", "<Cmd>Bdelete<CR>", description = "Unload current buffer" },
		})
	end,
}
