return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	lazy = false,
	event = { "BufRead", "BufWritePost" },
	init = function()
		require("nvim-treesitter").install({
			"bash",
			"c",
			"cmake",
			"cpp",
			"css",
			"diff",
			"dockerfile",
			"fennel",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"hcl",
			"html",
			"http",
			"hurl",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luap",
			"make",
			"markdown",
			"markdown_inline",
			"proto",
			"python",
			"query",
			"rasi",
			"regex",
			"rust",
			"scss",
			"terraform",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexprt()"
			end,
		})
	end,
}
