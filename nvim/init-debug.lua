vim.opt.signcolumn = 'no'
vim.opt.number = true
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
vim.opt.virtualedit = 'all'

vim.cmd('packadd packer.nvim')
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {'williamboman/nvim-lsp-installer',
    config = function()
      local installer = require('nvim-lsp-installer')
      installer.on_server_ready(function(server)
        server:setup({
          capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        })
      end)
    end
  }
  use {'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      require('cmp').setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip '},
	  { name = 'vsnip' },
        }),
        mapping = {
         ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
         ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  }
  use {'hrsh7th/cmp-vsnip'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'L3MON4D3/LuaSnip'}
  use {'saadparwaiz1/cmp_luasnip'}
end)
