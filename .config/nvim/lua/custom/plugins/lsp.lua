return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'smjonas/inc-rename.nvim',
    },
    config = function()
      require('custom.lsp')
    end,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {
      -- window = {
      --   blend = 0
      -- }
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("custom.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("custom.config").icons.kinds,
      }
    end,
  },
}
