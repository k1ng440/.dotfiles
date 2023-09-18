return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'L3MON4D3/LuaSnip',
      {
        'saadparwaiz1/cmp_luasnip',
        version = "2.*",
        build = 'make install_jsregexp',
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            path = { vim.fn.stdpath("config") .. "/snippets" },
          })
        end
      },
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-path",
      'rafamadriz/friendly-snippets',
    },
  },
}
