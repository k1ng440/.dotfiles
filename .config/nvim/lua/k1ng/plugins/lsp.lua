return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufEnter' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'b0o/schemastore.nvim',
      'folke/neoconf.nvim',
    },
    config = function()
      require('k1ng.lsp')
    end,
  },
  {
    'olexsmir/gopher.nvim',
    build = '<cmd>GoInstallDeps<cr>',
    ft = 'go',
    dependencies = { -- dependencies
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'someone-stole-my-name/yaml-companion.nvim',
    enabled = true,
    ft = { 'yaml' },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = true },
      },
    },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function(_, opts)
      vim.schedule(function()
        local cfg = require('yaml-companion').setup(opts)
        require('lspconfig')['yamlls'].setup(cfg)
        require('telescope').load_extension('yaml_schema')
      end)
    end,
  },
  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    opts = {
      separator = ' ',
      highlight = true,
      depth_limit = 5,
      icons = require('k1ng.core.icons').kinds,
    },
    config = function(_, opts)
      vim.schedule(function()
        vim.g.navic_silence = true

        local navic = require('nvim-navic')
        navic.setup(opts)

        require('k1ng.util').on_attach(function(client, buffer)
          if client.name == 'copilot' then
            return
          end

          if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, buffer)
          end
        end)
      end)
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    config = function()
      require('fidget').setup({
        notification = {
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },
}
