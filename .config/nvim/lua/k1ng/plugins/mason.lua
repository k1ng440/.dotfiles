return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    opts = function(_, opts)
      local sources = {
        'gopls',
        'golangci-lint',
        'stylua',
        'golines',
        'golangci-lint',
        'goimports_reviser',
        'gomodifytags',
        'codespell',
        'pretty-php',
        'prettierd',
      }

      if not opts.ensure_installed then
        opts.ensure_installed = {}
      end
      for _, source in ipairs(sources) do
        table.insert(opts.ensure_installed, source)
      end
    end,
  },
  {
    'zapling/mason-lock.nvim',
    init = function()
      require('mason-lock').setup({
        lockfile_path = vim.fn.stdpath('config') .. '/mason-lock.json', -- (default)
      })
    end,
  },
}
