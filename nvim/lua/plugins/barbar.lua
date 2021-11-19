vim.g.bufferline = {
	animation = false,
	closable = false,
	maximum_padding = 1,
	--icon_separator_active = '',
	icons = false,
	icon_separator_inactive = ' ',
	icon_close_tab = '',
	icon_close_tab_modified = '',
	icon_pinned = '',
}

vim.cmd[[
augroup BARBAR
	au!
	au BufWinEnter NvimTree lua require'bufferline.state'.set_offset(30)
	au BufWinLeave NvimTree lua require'bufferline.state'.set_offset(0)
augroup END
]]

vim.cmd[[
	hi! link BufferOffset NvimTreeNormal
]]
