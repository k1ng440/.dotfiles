return {
  {
    'williamboman/mason.nvim',
    event = 'BufEnter',
    opts = function(_, opts)
      local sources = {
        'gopls',
        'stylua',
        'prettierd',
        'golines',
        'golangci-lint',
        'goimports_reviser',
        'gomodifytags',
        'codespell',
        'mdformat',
      }
      if not opts.ensure_installed then
        opts.ensure_installed = {}
      end
      for _, source in ipairs(sources) do
        table.insert(opts.ensure_installed, source)
      end
    end,
  },
}
