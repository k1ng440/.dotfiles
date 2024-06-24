return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      {
        'saadparwaiz1/cmp_luasnip',
        version = '2.*',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load({
            path = { vim.fn.stdpath('config') .. '/snippets' },
          })
        end,
      },
    },
    config = function()
      require('k1ng.plugin-configs.cmp')
    end,
  },
  { 'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter', dependencies = 'hrsh7th/nvim-cmp' },
}
