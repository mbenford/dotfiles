vim.lsp.enable({
	"basedpyright",
	"bashls",
	"biome",
	"cssls",
	"cssmodules_ls",
	"dockerls",
	"eslint",
	"gopls",
	"html",
	"lua_ls",
	"marksman",
	"rust_analyzer",
	"taplo",
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
