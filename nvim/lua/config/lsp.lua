vim.lsp.enable({
	"basedpyright",
	"bashls",
	"cssls",
	"cssmodules_ls",
	"dockerls",
	"eslint",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"rust_analyzer",
	"terraformls",
	"ts_ls",
	"yamlls",
})

-- Dirty hack to center the cursor after a jump
do
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
end
