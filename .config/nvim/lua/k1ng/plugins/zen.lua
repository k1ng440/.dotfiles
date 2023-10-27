return {
  'folke/zen-mode.nvim',
  dependencies = {
    'folke/twilight.nvim',
  },

  cmd = 'ZenMode',
  keys = {
    { '<leader>zm', '<cmd>ZenMode<cr>', '[Z]en [M]ode' },
  },
  opts = {
    window = {
      backdrop = 0.5,
    },
    plugins = {
      twilight = { enabled = true },
      tmux = { enabled = true },
      kitty = { enabled = true },
    },
  },
}
