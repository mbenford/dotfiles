require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	}
end

local signs = {
	Error = " ",
	Warning = " ",
	Hint = " ",
	Information = " "
}
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = false,
		underline = true,
		update_in_insert = false,
	}
)

local map = require'utils'.map
map{'n', 'gd', ':lua vim.lsp.buf.definition()<cr>'}
map{'n', 'gi', ':lua vim.lsp.buf.implementation()<cr>'}

vim.cmd[[
	autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
]]

vim.cmd[[
	hi LspDiagnosticsUnderlineError gui=undercurl guisp=#993939
	hi LspDiagnosticsUnderlineWarning gui=undercurl guisp=#93691d
	hi LspDiagnosticsUnderlineHint gui=undercurl guisp=#8a3fa0
	hi LspDiagnosticsUnderlineInformation gui=undercurl guisp=#2b6f77
]]
