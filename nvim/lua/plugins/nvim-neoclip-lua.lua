require('neoclip').setup({})
require('telescope').load_extension('neoclip')

local map = require('utils.map').map
local themes = require('plugins.telescope-themes')
map('n', '<leader>fc', function() require('telescope').extensions.neoclip.default(themes.default()) end)
