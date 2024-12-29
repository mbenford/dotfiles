return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		require("lspconfig.ui.windows").default_options.border = "rounded"

		-- Dirty hack to center the cursor after a jump
		local patch = function(fn_name)
			local fn = vim.lsp.util[fn_name]
			vim.lsp.util[fn_name] = function(location, offset_encoding, reuse_win)
				local success = fn(location, offset_encoding, reuse_win)
				if success then
					vim.cmd.normal("zz")
				end
				return success
			end
		end

		patch("jump_to_location")
		patch("show_document")
	end,
}
