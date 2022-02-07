local o = vim.opt
o.backup = false
o.colorcolumn = '120'
o.completeopt = { 'menuone', 'noselect' }
o.confirm = true
o.cursorline = true
o.expandtab = false
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldlevel = 99
o.foldnestmax = 3
-- o.foldtext = [[getline(v:foldstart) . '...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- o.foldmethod = 'marker'
o.hidden = true
o.hlsearch = false
o.ignorecase = true
o.list = true
o.listchars = { trail = '·', tab = '  ' }
o.mouse = 'a'
o.numberwidth = 2
o.relativenumber = true
o.ruler = false
o.scrolloff = 3
o.shiftwidth = 2
o.shortmess:append('I')
o.shortmess:append('S')
o.shortmess:append('a')
o.shortmess:append('s')
o.shortmess:append('c')
o.showcmd = false
o.showmode = false
o.sidescroll = 1
o.sidescrolloff = 5
o.signcolumn = 'yes:1'
o.smartcase = true
o.smartindent = true
o.spelllang = { 'en_us', 'pt_br' }
o.spelloptions = 'camel'
o.softtabstop = 2
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.title = true
o.titlestring = '%{substitute(getcwd(),$HOME,"~","")} - Neovim'
o.ttimeoutlen = 0
o.undofile = true
o.updatetime = 250
o.virtualedit = 'all'
o.wildmode = 'full'
o.wrap = false
