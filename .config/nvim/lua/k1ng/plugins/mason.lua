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
}
