local g = vim.g
g.mapleader = " "
g.maplocalleader = "\\"

-- Disable unused providers
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

local o = vim.opt
o.backup = false
o.colorcolumn = "120"
o.completeopt = { "menu", "menuone", "noinsert", "noselect" }
o.confirm = true
o.cursorline = true
o.expandtab = false
o.foldcolumn = "auto"
o.foldlevel = 99
o.foldlevelstart = -1
o.foldenable = true
o.fillchars:append({ eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" })
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.laststatus = 3
o.linebreak = true
o.list = true
o.listchars = { tab = "  ", trail = "·" }
o.mouse = "a"
o.numberwidth = 2
o.number = true
o.relativenumber = true
o.ruler = false
o.scrolloff = 3
o.shiftwidth = 2
o.shortmess:append({ I = true, a = true, s = true, c = true })
o.showcmd = false
o.showmode = false
o.sidescroll = 1
o.sidescrolloff = 5
o.signcolumn = "auto:1-2"
o.smartcase = true
o.smartindent = false
o.spell = false
o.spelllang = { "en_us", "pt_br" }
o.spelloptions = "camel"
o.softtabstop = 2
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.title = true
o.titlestring = '%{fnamemodify(getcwd(), ":~")} - Neovim'
o.ttimeoutlen = 0
o.undofile = true
o.updatetime = 250
o.virtualedit = ""
o.wildmode = "full"
o.winminheight = 0
o.winminwidth = 0
o.wrap = false
