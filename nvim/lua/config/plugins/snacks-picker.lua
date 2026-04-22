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
				preset = "vertical",
				preview = false,
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
						foldcolumn = "0",
						signcolumn = "no",
						statuscolumn = " ",
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
				Snacks.picker.files()
			end,
			desc = "Files",
		},
		{
			"<Leader>fa",
			function()
				Snacks.picker.files({ hidden = true, ignored = true })
			end,
			desc = "All Files",
		},
		{
			"<Leader>fo",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Recent Files",
		},
		{
			"<Leader>fe",
			function()
				Snacks.picker.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<Leader>fg",
			function()
				Snacks.picker.grep({ regex = false, layout = { preview = true } })
			end,
			desc = "Live grep",
		},
		{
			"<Leader>fG",
			function()
				Snacks.picker.grep({ regex = true, args = { "-U" }, title = "Grep (multiline)", layout = { preview = true } })
			end,
			desc = "Live grep (multiline)",
		},
		{
			"<Leader>f*",
			function()
				Snacks.picker.grep_word({ regex = false, layout = { preview = true } })
			end,
			mode = { "n", "x" },
			desc = "Grep Word",
		},
		{
			"<Leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<Leader>f<Space>",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<Leader>fr",
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<Leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},
		{
			"<Leader>f;",
			function()
				Snacks.picker.commands()
			end,
			desc = "Help",
		},
		{
			"<Leader>;",
			function()
				Snacks.picker.command_history({ layout = { preset = "vertical" } })
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

				Snacks.picker({
					items = filetypes,
					source = "filetypes",
					layout = "select",
					format = function(item)
						local icon, icon_hl = require("snacks.util").icon(item.text, "filetype")
						return {
							{ icon .. " ", icon_hl },
							{ item.text },
						}
					end,
					confirm = function(picker, item)
						picker:close()
						vim.cmd.set("ft=" .. item.text)
					end,
				})
			end,
			desc = "Filetypes",
		},
		{
			"<Leader>fs",
			function()
				Snacks.picker.spelling()
			end,
			desc = "Filetypes",
		},
		{
			"<Leader>fn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notifications",
		},
		{
			"<Leader>ld",
			function()
				Snacks.picker.lsp_definitions({ layout = { preview = true } })
			end,
			desc = "LSP Definitions",
		},
		{
			"<Leader>lr",
			function()
				Snacks.picker.lsp_references({ layout = { preview = true } })
			end,
			desc = "LSP References",
		},
		{
			"<Leader>li",
			function()
				Snacks.picker.lsp_implementations({ layout = { preview = true } })
			end,
			desc = "LSP Implementations",
		},
		{
			"<Leader>ls",
			function()
				Snacks.picker.lsp_symbols({ layout = { preview = true } })
			end,
			desc = "LSP Symbols",
		},
		{
			"<Leader>lci",
			function()
				Snacks.picker.lsp_incoming_calls({ layout = { preview = true } })
			end,
			desc = "LSP incoming calls",
		},
		{
			"<Leader>lco",
			function()
				Snacks.picker.lsp_outgoing_calls({ layout = { preview = true } })
			end,
			desc = "LSP outgoing calls",
		},
	},
}
