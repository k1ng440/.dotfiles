return {
  'aserowy/tmux.nvim',
  enabled = true,
  lazy = false,
  config = function()
    return require('tmux').setup({
      copy_sync = {
        enable = false,
      },
    })
  end,
}
