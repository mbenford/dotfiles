return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufRead", "BufWritePost" },
	dependencies = {
		"nvim-treesitter/playground",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
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
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luap",
				"make",
				"markdown",
				"markdown_inline",
				"norg",
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
				"yaml",
			},
			playground = { enable = true },
			highlight = { enable = true },
			indent = { enable = false },
			autotag = { enable = true },
			matchup = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "<Up>",
					node_decremental = "<Down>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
		})

		local ts = vim.treesitter
		ts.language.register("css", "pcss")
	end,
}
