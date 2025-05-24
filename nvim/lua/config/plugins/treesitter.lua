return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufRead", "BufWritePost" },
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = false,
			sync_install = false,
			ignore_install = {},
			modules = {},

			ensure_installed = {
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
				"vimdoc",
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
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})

		local ts = vim.treesitter
		ts.language.register("css", "pcss")
	end,
}
