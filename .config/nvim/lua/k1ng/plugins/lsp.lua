return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'smjonas/inc-rename.nvim',
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require('k1ng.lsp')
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      'L3MON4D3/LuaSnip',
      {
        'saadparwaiz1/cmp_luasnip',
        version = "2.*",
        build = 'make install_jsregexp',
      },
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-path",
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-calc',
      'onsails/lspkind.nvim',
    },
  },
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {
      text = {
        spinner = "dots",
        done = "󰗡",
        commenced = "init",
        completed = "done",
      },
      window = { blend = 0 },
      sources = {
        ["copilot"] = { ignore = true },
        ["null-ls"] = { ignore = true },
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("k1ng.util").on_attach(function(client, buffer)
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
        icons = require("k1ng.configs.icons").kinds,
      }
    end,
  },
}
