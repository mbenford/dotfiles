return function(server_name)
	local config = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		},
		on_attach = function(client, bufnr)
			local legendary = require("legendary")

			legendary.keymaps({
				{ "K", vim.lsp.buf.hover, opts = { buffer = bufnr }, description = "LSP Hover" },
				{ "<C-k>", vim.lsp.buf.signature_help, opts = { buffer = bufnr }, description = "LSP Signature Help" },
				{ "<leader>rr", vim.lsp.buf.rename, opts = { buffer = bufnr }, description = "LSP Rename" },
				{ "<leader>la", vim.lsp.buf.code_action, description = "LSP Code Action" },
				{
					"<leader>lh",
					function()
						vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
					end,
					opts = { buffer = bufnr },
					description = "LSP Inlay Hints",
				},
				{ "<leader>l?", "<Cmd>LspInfo<CR>", description = "LSP Info" },
			})
		end,
	}

	local ok, server_config = pcall(require, "config.language-servers." .. server_name)
	if ok then
		config = vim.tbl_deep_extend("force", config, server_config)
	end
	return config
end
