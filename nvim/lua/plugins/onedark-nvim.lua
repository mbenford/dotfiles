local onedark = require('onedark')
onedark.setup({
    style = 'dark',
    code_style = {
        comments = 'none',
    },
    toggle_style_key = '<nop>',
    diagnostics = {
        darker = false,
    },
    highlights = {
        Pmenu = { bg = '$bg_d' },
        FloatBorder = { fg = '$light_grey' },
        FloatTitle = { fg = 'white', bg = '$cyan' },
        TablineFill = { bg = '$bg_d' },
        StatusLine = { bg = '$bg_d' },
        StatusLineNC = { bg = '$bg_d' },
        SpellBad = { fg = 'none', bg = 'none', sp = 'green', fmt = 'undercurl' },
        Folded = { fg = '$grey', bg = 'none' },
        TextYank = { fg = '$orange', bg = 'none', fmt = 'reverse' },
    },
})
onedark.load()

local set_hl = vim.api.nvim_set_hl
set_hl(0, 'LspReferenceRead', { link = 'Visual' })
set_hl(0, 'LspReferenceWrite', { link = 'Visual' })
set_hl(0, 'LspReferenceText', { link = 'CursorLine' })
set_hl(0, 'LspSignatureActiveParameter', { link = 'IncSearch' })
