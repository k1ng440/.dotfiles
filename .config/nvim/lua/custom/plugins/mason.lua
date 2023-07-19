return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      local sources = {
        'gopls', 'stylua', 'prettierd', 'golines', 'golangci-lint', 'goimports_reviser', 'gomodifytags',
      }
      if not opts.ensure_installed then opts.ensure_installed = {} end
      for _, source in ipairs(sources) do
        table.insert(opts.ensure_installed, source)
      end
    end,
  },
  'williamboman/mason-lspconfig.nvim',
  'folke/neodev.nvim',
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup {
        auto_update = false,
        debounce_hours = 24,
        ensure_installed = {
          "black", "isort", 'lua-language-server', 'vim-language-server', 'gopls', 'stylua',
          'shellcheck', 'editorconfig-checker', 'gofumpt', 'golines', 'gomodifytags', 'gotests',
          'impl', 'json-to-struct', 'luacheck', 'misspell', 'revive', 'shellcheck', 'shfmt',
          'staticcheck', 'vint', 'golangci-lint', 'bash-language-server', 'ripgrep', 'fd',
        },
      }
    end,
  },
}
