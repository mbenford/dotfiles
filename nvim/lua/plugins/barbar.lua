vim.g.bufferline = {
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = false,
  clickable = false,

  exclude_ft = {},
  exclude_name = {},

  icons = false,
  icon_custom_colors = false,

  icon_separator_active = ' ',
  icon_separator_inactive = ' ',
  icon_close_tab = '',
  icon_close_tab_modified = '',
  icon_pinned = '',

  insert_at_end = false,
  insert_at_start = false,

  maximum_padding = 1,
  maximum_length = 30,

  no_name_title = '[No Name]',
}

local map = require'map'
map.n{'<C-j>', '<cmd>BufferPrevious<cr>'}
map.n{'<C-k>', '<cmd>BufferNext<cr>'}

local colors = require'onedark.colors'
local hl = require'highlight'
hl.link{'BufferOffset', 'BufferTabpageFill'}
hl.link{'BufferVisible', 'BufferInactive'}
hl.link{'BufferVisibleSign', 'BufferInactive'}
hl.add{'BufferVisibleMod', guifg=colors.dark_yellow, guibg=colors.bg_d}
hl.link{'BufferInactiveMod', 'BufferVisibleMod'}
