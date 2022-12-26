return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		'kevinhwang91/promise-async',
	},
	config = {
		provider_selector = function()
			return { 'treesitter', 'indent' }
		end,
		fold_virt_text_handler = function(virttext, lnum, endlnum, width, truncate)
			local newvirttext = {}
			local suffix = ('  %d '):format(endlnum - lnum)
			local sufwidth = vim.fn.strdisplaywidth(suffix)
			local targetwidth = width - sufwidth
			local curwidth = 0
			for _, chunk in ipairs(virttext) do
				local chunktext = chunk[1]
				local chunkwidth = vim.fn.strdisplaywidth(chunktext)
				if targetwidth > curwidth + chunkwidth then
					table.insert(newvirttext, chunk)
				else
					chunktext = truncate(chunktext, targetwidth - curwidth)
					local hlgroup = chunk[2]
					table.insert(newvirttext, { chunktext, hlgroup })
					chunkwidth = vim.fn.strdisplaywidth(chunktext)
					if curwidth + chunkwidth < targetwidth then
						suffix = suffix .. (' '):rep(targetwidth - curwidth - chunkwidth)
					end
					break
				end
				curwidth = curwidth + chunkwidth
			end
			table.insert(newvirttext, { suffix, 'moremsg' })
			return newvirttext
		end,
	},
	init = function()
		local ufo = require('ufo')
		require('legendary').keymaps({
			{ 'zR', ufo.openAllFolds, description = '' },
			{ 'zr', ufo.openAllFolds, description = '' },
			{ 'zM', ufo.closeAllFolds, description = '' },
			{ 'zm', ufo.closeFoldsWith, description = '' },
		})
	end,
}
