return {
	"stevearc/conform.nvim",
	event = { "BufRead", "InsertEnter", "BufWritePre" },
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			go = { "goimports" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "jq" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "black" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			terraform = { "terraform_fmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			["*"] = { "trim_whitespace" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat then
				return {
					timeout_ms = 500,
					quiet = true,
					lsp_fallback = false,
					formatters = { "trim_whitespace" },
				}
			end

			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		local lazy = require("legendary.toolbox").lazy
		local legendary = require("legendary")
		legendary.keymaps({
			{ "<Leader><Leader>f", lazy(conform.format, { async = true, lsp_fallback = true }), description = "" },
		})
		legendary.commands({
			{
				"FormatToggle",
				function()
					vim.g.disable_autoformat = not vim.g.disable_autoformat
					vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
				end,
				description = "Toggle autoformat on saving",
			},
		})
	end,
}
