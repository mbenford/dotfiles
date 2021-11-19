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

local map = require'map'
map.n{'<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>'}
map.n{'<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>'}
map.n{'<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>'}
map.n{'<leader>ge', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>'}

vim.cmd[[
	autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
]]
