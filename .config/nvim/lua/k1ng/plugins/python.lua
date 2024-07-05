return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    event = 'VeryLazy',
    branch = 'regexp',
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    cmd = {
      'VenvSelect',
      'VenvSelectCached',
    },
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },
}
