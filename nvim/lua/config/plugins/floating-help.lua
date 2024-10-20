return {
	"Tyler-Barham/floating-help.nvim",
	enabled = false,
	opts = {},
	config = function(_, opts)
		require("floating-help").setup(opts)
		-- local function cmd_abbrev(abbrev, expansion)
		-- 	local cmd = "cabbr "
		-- 		.. abbrev
		-- 		.. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
		-- 		.. expansion
		-- 		.. '" : "'
		-- 		.. abbrev
		-- 		.. '")<CR>'
		-- 	vim.cmd(cmd)
		-- end
		--
		-- -- Redirect `:h` to `:FloatingHelp`
		-- cmd_abbrev("h", "FloatingHelp")
		-- cmd_abbrev("help", "FloatingHelp")
		-- cmd_abbrev("helpc", "FloatingHelpClose")
		-- cmd_abbrev("helpclose", "FloatingHelpClose")
	end,
}
