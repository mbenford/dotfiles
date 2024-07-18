return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	enabled = false,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local function select(index)
			harpoon:list():select(index)
		end

		local lazy = require("legendary.toolbox").lazy
		require("legendary").keymaps({
			{
				"<Leader>ha",
				function()
					harpoon:list():append()
					vim.notify("Added to Harpoon")
				end,
				description = "Add current buffer to Harpoon",
			},
			{
				"<Leader>hd",
				function()
					harpoon:list():remove()
					vim.notify("Removed from Harpoon")
				end,
				description = "Remove current buffer from Harpoon",
			},
			{
				"<Leader>hh",
				function()
					local items = {}
					for idx, item in ipairs(harpoon:list().items) do
						table.insert(items, { idx = idx, value = item.value })
					end

					vim.ui.select(items, {
						prompt = "Harpoon",
						format_item = function(item)
							return item.idx .. " " .. item.value
						end,
					}, function(_, idx)
						select(idx)
					end)
				end,
				description = "Open Harpoon",
			},
			{
				"<Leader>hc",
				function()
					harpoon:list():clear()
					vim.notify("Cleared Harpoon")
				end,
				description = "Clear Harpoon",
			},
			{ "<Leader>1", lazy(select, 1), description = "Open Harpoon entry #1" },
			{ "<Leader>2", lazy(select, 2), description = "Open Harpoon entry #2" },
			{ "<Leader>3", lazy(select, 3), description = "Open Harpoon entry #3" },
			{ "<Leader>4", lazy(select, 4), description = "Open Harpoon entry #4" },
		})
	end,
}
