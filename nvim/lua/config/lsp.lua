return function(server_name)
	local config = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		},
		on_attach = function(client, bufnr)
			require("which-key").add({
				{ "K", vim.lsp.buf.hover, buffer = bufnr, desc = "LSP Hover" },
				{ "<C-k>", vim.lsp.buf.signature_help, buffer = bufnr, desc = "LSP Signature Help" },
				{ "<leader>rr", vim.lsp.buf.rename, buffer = bufnr, desc = "LSP Rename" },
				{ "<leader>la", vim.lsp.buf.code_action, desc = "LSP Code Action" },
				{
					"<leader>lh",
					function()
						vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
					end,
					buffer = bufnr,
					desc = "LSP Inlay Hints",
				},
				{ "<leader>l?", "<Cmd>LspInfo<CR>", desc = "LSP Info" },
			})
		end,
	}

	local ok, server_config = pcall(require, "config.language-servers." .. server_name)
	if ok then
		config = vim.tbl_deep_extend("force", config, server_config)
	end
	return config
end
