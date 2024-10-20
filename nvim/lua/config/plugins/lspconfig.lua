return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		require("lspconfig.ui.windows").default_options.border = "rounded"

		-- Dirty hack to center the cursor after a jump
		local jump = vim.lsp.util.jump_to_location
		vim.lsp.util.jump_to_location = function(location, offset_encoding, reuse_win)
			local success = jump(location, offset_encoding, reuse_win)
			if success then
				vim.cmd.normal("zz")
			end
			return success
		end
	end,
}
