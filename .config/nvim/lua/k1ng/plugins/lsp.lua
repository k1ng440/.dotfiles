return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    -- event = 'LazyFile',
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'folke/neoconf.nvim',
      'smjonas/inc-rename.nvim',
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
    'creativenull/efmls-configs-nvim',
    event = 'LspAttach',
    version = 'v1.x.x',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  {
    'someone-stole-my-name/yaml-companion.nvim',
    enabled = false,
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
      local cfg = require('yaml-companion').setup(opts)
      require('lspconfig')['yamlls'].setup(cfg)
      require('telescope').load_extension('yaml_schema')
    end,
  },
  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    init = function()
      vim.g.navic_silence = true
      require('k1ng.util').on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = ' ',
        highlight = true,
        depth_limit = 5,
        icons = require('k1ng.configs.icons').kinds,
      }
    end,
  },
}
