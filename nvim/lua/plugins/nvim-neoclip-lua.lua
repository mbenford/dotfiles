require'neoclip'.setup{}

require'telescope'.load_extension('neoclip')

local map = require'utils.map'
map.n{'<leader>fc', '<cmd>Telescope neoclip<cr>'}
