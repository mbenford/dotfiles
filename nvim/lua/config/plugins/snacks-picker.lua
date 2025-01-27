return {
	"folke/snacks.nvim",
	init = function()
		require("which-key").add({
			{ "<Leader>f", group = "Pickers" },
		})
	end,
	opts = {
		picker = {
			layout = {
				preset = "vscode",
				layout = {
					backdrop = false,
				},
			},
			formatters = {
				file = {
					filename_first = true,
				},
			},
			previewers = {
				git = {
					native = false,
				},
			},
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
				preview = {
					wo = {
						number = false,
						relativenumber = false,
					},
				},
			},
		},
	},
	keys = {
		{
			"<Leader>ff",
			function()
				require("snacks").picker.files()
			end,
			desc = "Files",
		},
		{
			"<Leader>fa",
			function()
				require("snacks").picker.files({ hidden = true, ignored = true })
			end,
			desc = "All Files",
		},
		{
			"<Leader>fo",
			function()
				require("snacks").picker.recent({ filter = { cwd = true } })
			end,
			desc = "Files",
		},
		{
			"<Leader>fg",
			function()
				require("snacks").picker.grep({ regex = false })
			end,
			desc = "Live grep",
		},
		{
			"<Leader>f*",
			function()
				require("snacks").picker.grep_word({ regex = false })
			end,
			mode = { "n", "x" },
			desc = "Grep Word",
		},
		{
			"<Leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<Leader>f<Space>",
			function()
				require("snacks").picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<Leader>fr",
			function()
				require("snacks").picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<Leader>fh",
			function()
				require("snacks").picker.help()
			end,
			desc = "Help",
		},
		{
			"<Leader>ft",
			function()
				local filetypes = {}
				for _, ft in ipairs(vim.fn.getcompletion("", "filetype")) do
					table.insert(filetypes, { text = ft, name = ft })
				end

				require("snacks").picker({
					items = filetypes,
					source = "Filetypes",
					format = function(item, picker)
						local icon, icon_hl = require("snacks.util").icon(item.text, "filetype")
						return {
							{ icon .. " ", icon_hl },
							{ item.text },
						}
					end,
					confirm = function(picker, item)
						picker:close()
						vim.cmd("set ft=" .. item.text)
					end,
				})
			end,
			desc = "Filetypes",
		},
		{
			"<Leader>fs",
			function()
				-- require("snacks").picker.filetypes()
			end,
			desc = "Filetypes",
		},
		{
			"<Leader>ld",
			function()
				require("snacks").picker.lsp_definitions()
			end,
			desc = "LSP Definitions",
		},
		{
			"<Leader>lr",
			function()
				require("snacks").picker.lsp_references()
			end,
			desc = "LSP References",
		},
		{
			"<Leader>li",
			function()
				require("snacks").picker.lsp_implementations()
			end,
			desc = "LSP Implementations",
		},
		{
			"<Leader>ls",
			function()
				require("snacks").picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<Leader>lci",
			"<Cmd>Telescope lsp_incoming_calls<CR>",
			desc = "LSP incoming calls",
		},
		{
			"<Leader>lco",
			"<Cmd>Telescope lsp_outgoing_calls<CR>",
			desc = "LSP outgoing calls",
		},
	},
}
