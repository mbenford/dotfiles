return {
	'ggandor/leap.nvim',
	event = 'BufRead',
	config = function ()
		local leap = require('leap')
		leap.setup({})
		leap.add_default_mappings()

		local colors = require('onedark.colors')
		local hl = require('utils.highlight')
		hl.set('LeapLabelPrimary', { fg = colors.bg0, bg = colors.orange })

		local function get_line_starts(winid)
			local wininfo = vim.fn.getwininfo(winid)[1]
			local cur_line = vim.fn.line('.')

			local targets = {}
			local lnum = wininfo.topline
			while lnum <= wininfo.botline do
				local fold_end = vim.fn.foldclosedend(lnum)
				if fold_end ~= -1 then
					lnum = fold_end + 1
				else
					if lnum ~= cur_line then
						table.insert(targets, { pos = { lnum, 1 } })
					end
					lnum = lnum + 1
				end
			end

			local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)['row']
			local function screen_rows_from_cur(t)
				local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])['row']
				return math.abs(cur_screen_row - t_screen_row)
			end

			table.sort(targets, function(t1, t2)
				return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
			end)

			if #targets >= 1 then
				return targets
			end
		end

		local function leap_to_line()
			local winid = vim.api.nvim_get_current_win()
			require('leap').leap({
				target_windows = { winid },
				targets = get_line_starts(winid),
			})
		end

		require('legendary').keymaps({
			{ 'gl', leap_to_line, description = '' },
		})
	end
}
