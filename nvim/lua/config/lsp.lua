return function(server_name)
	local capabilities
	local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then
		capabilities = cmp.default_capabilities()
	else
		local blink_ok, blink = pcall(require, "blink.cmp")
		if blink_ok then
			capabilities = blink.get_lsp_capabilities()
		end
	end

	local config = {
		capabilities = capabilities,
		handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		},
		on_attach = function(client, bufnr)
			require("which-key").add({
				{ "<Leader>lh", vim.lsp.buf.hover, buffer = bufnr, desc = "LSP Hover" },
				{ "<C-k>", vim.lsp.buf.signature_help, buffer = bufnr, desc = "LSP Signature Help" },
				{ "<Leader>rr", vim.lsp.buf.rename, buffer = bufnr, desc = "LSP Rename" },
				{ "<Leader>la", vim.lsp.buf.code_action, desc = "LSP Code Action" },
				-- {
				-- 	"<Leader>lh",
				-- 	function()
				-- 		vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
				-- 	end,
				-- 	buffer = bufnr,
				-- 	desc = "LSP Inlay Hints",
				-- },
				{ "<Leader>l?", "<Cmd>LspInfo<CR>", desc = "LSP Info" },
			})
		end,
	}

	local ok, server_config = pcall(require, "config.language-servers." .. server_name)
	if ok then
		config = vim.tbl_deep_extend("force", config, server_config)
	end
	return config
end
