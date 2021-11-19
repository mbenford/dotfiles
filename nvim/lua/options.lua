local o = vim.opt
o.backup = false
o.colorcolumn = '120'
o.completeopt = {'menuone', 'noselect'}
o.confirm = true
o.cursorline = true
o.expandtab = false
o.foldlevel = 99
o.foldtext = [[substitute(getline(v:foldstart),'\\\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
o.hidden = true
o.hlsearch = false
o.ignorecase = true
o.list = true
o.listchars = {trail = '·', tab = '  '}
o.mouse = 'a'
o.numberwidth = 2
o.relativenumber = true
o.scrolloff = 5
o.shiftwidth = 2
o.shortmess:append('I')
o.shortmess:remove('S')
o.showcmd = false
o.showmode = false
o.sidescroll = 1
o.sidescrolloff = 10
o.signcolumn = 'yes:1'
o.smartcase = true
o.smartindent = true
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
o.updatetime = 500
o.wildmode = 'full'
o.wrap = false
